import 'package:flutter/material.dart';
import 'todo_page.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../repositories/task_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Todo")),

      body: Center(
        child: SizedBox(
          width: 350,

          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Text(
                    "Codice lista",

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: controller,

                    textCapitalization: TextCapitalization.characters,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      hintText: "TEAM01",
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      child: const Text("Apri"),

                      onPressed: () async {
                        final code = controller.text.trim().toUpperCase();

                        if (code.isEmpty) {
                          return;
                        }

                        final repository = TaskRepository();

                        final listId = await repository.openList(code);

                        if (!mounted) {
                          return;
                        }

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) {
                              return ChangeNotifierProvider(
                                create: (_) {
                                  return TaskProvider(listId);
                                },

                                child: TodoPage(listId: listId),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
