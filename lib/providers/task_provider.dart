import 'package:flutter/material.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../services/socket_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository repository = TaskRepository();
  final SocketService socketService = SocketService();
  final String listId;

  List<Task> _tasks = [];
  bool _loading = false;

  List<Task> get tasks => _tasks;
  bool get loading => _loading;

  TaskProvider(this.listId) {
    socketService.connect();

    socketService.joinList(listId);

    socketService.onTaskCreated(_taskCreated);

    socketService.onTaskUpdated(_taskUpdated);

    socketService.onTaskDeleted(_taskDeleted);

    loadTasks();
  }

  Future<void> loadTasks() async {
    _loading = true;
    notifyListeners();

    try {
      _tasks = await repository.getTasks(listId);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    await repository.addTask(listId, title.trim());
  }

  Future<void> updateTask(Task task) async {
    await repository.updateTask(task);
  }

  Future<void> deleteTask(Task task) async {
    await repository.deleteTask(task.id);
  }

  void _taskCreated(Task task) {
    _tasks.add(task);

    notifyListeners();
  }

  void _taskUpdated(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);

    if (index == -1) return;

    _tasks[index] = task;

    notifyListeners();
  }

  void _taskDeleted(int id) {
    _tasks.removeWhere((t) => t.id == id);

    notifyListeners();
  }

  @override
  void dispose() {
    socketService.leaveList(listId);

    socketService.disconnect();

    super.dispose();
  }
}
