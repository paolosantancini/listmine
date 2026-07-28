import '../models/task.dart';
import '../services/api_service.dart';

class TaskRepository {
  final ApiService api = ApiService();

  Future<List<Task>> getTasks(String listId) {
    return api.getTasks(listId);
  }

  Future<void> addTask(String listId, String title) {
    return api.addTask(listId, title);
  }

  Future<void> updateTask(Task task) {
    return api.updateTask(task);
  }

  Future<void> deleteTask(int id) {
    return api.deleteTask(id);
  }

  Future<String> openList(String listId) {
    return api.openList(listId);
  }
}
