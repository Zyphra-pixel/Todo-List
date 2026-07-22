import 'package:flutter/material.dart';
import 'package:to_do_list_pro/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onCheck;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onCheck,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(23),
      ),
      child: ListTile(
        leading: Checkbox(value: task.isChecked, onChanged: onCheck),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isChecked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationThickness: 3,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
            const SizedBox(width: 8),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}
