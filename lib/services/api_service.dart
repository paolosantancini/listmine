import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task.dart';

class ApiService {
  String server = Uri.base.origin;

  Future<List<Task>> getTasks(String listId) async {
    final response = await http.get(
      Uri.parse("${Uri.base.origin}/api/lists/$listId/tasks"),
    );

    if (response.statusCode != 200) {
      throw Exception("Errore server");
    }

    final json = jsonDecode(response.body);

    return (json as List).map((e) => Task.fromJson(e)).toList();
  }

  Future<void> addTask(String listId, String title) async {
    await http.post(
      Uri.parse("${Uri.base.origin}/api/lists/$listId/tasks"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"title": title}),
    );
  }

  Future<void> updateTask(Task task) async {
    await http.put(
      Uri.parse("${Uri.base.origin}/api/tasks/${task.id}"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"title": task.title, "done": task.done}),
    );
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse("${Uri.base.origin}/api/tasks/$id"));
  }

  Future<String> openList(String listId) async {
    final response = await http.post(
      Uri.parse("${Uri.base.origin}/api/lists"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"id": listId}),
    );

    if (response.statusCode != 200) {
      throw Exception("Impossibile aprire la lista");
    }

    final json = jsonDecode(response.body);

    return json["id"];
  }
}
