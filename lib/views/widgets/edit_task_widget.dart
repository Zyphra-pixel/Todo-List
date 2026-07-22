import 'package:flutter/material.dart';

class EditTaskWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const EditTaskWidget({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task'),
      content: TextField(controller: controller, autofocus: true),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            onSave();
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
