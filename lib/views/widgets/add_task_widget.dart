import 'package:flutter/material.dart';

class AddTaskWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  const AddTaskWidget({
    super.key,
    required this.onAdd,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelText: 'Enter task...',
            ),
          ),
        ),
        SizedBox(width: 10.0),
        FilledButton(onPressed: onAdd, child: Text('Add')),
      ],
    );
  }
}
