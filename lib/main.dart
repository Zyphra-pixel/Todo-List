import 'package:flutter/material.dart';
import 'views/pages/widget_tree.dart';

void main() {
  runApp(const ToDoList());
}

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WidgetTree(),
    );
  }
}
