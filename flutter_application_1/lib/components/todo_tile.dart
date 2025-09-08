import 'package:flutter/material.dart';


class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback? onDelete;

  TodoTile({
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.blueGrey,
                activeColor: Colors.white,
                value: isCompleted,
                onChanged: onChanged,
              ),
              Expanded(
                child: Text(
                  taskName,
                  style: isCompleted
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 3,
                        )
                      : TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.none,
                        ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
