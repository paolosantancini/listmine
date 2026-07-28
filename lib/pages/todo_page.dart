import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TodoPage extends StatefulWidget {
  final String listId;
  const TodoPage({super.key, required this.listId});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Lista: ${widget.listId}")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Nuova attività",
                          ),
                          onSubmitted: (_) async {
                            await provider.addTask(controller.text);
                            controller.clear();
                          },
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          await provider.addTask(controller.text);
                          controller.clear();
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      final Task task = provider.tasks[index];

                      return TaskTile(
                        task: task,

                        onChanged: (_) async {
                          await provider.updateTask(
                            task.copyWith(done: !task.done),
                          );
                        },

                        onDelete: () async {
                          await provider.deleteTask(task);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
