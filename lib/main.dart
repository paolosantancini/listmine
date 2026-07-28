import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {

  runApp(
    const TodoApp(),
  );

}

class TodoApp extends StatelessWidget {

  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Shared Todo",

      theme: ThemeData(

        useMaterial3: true,

        colorSchemeSeed: Colors.blue,

      ),

      home: const HomePage(),

    );

  }

}
