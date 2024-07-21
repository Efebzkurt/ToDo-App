import 'package:flutter/material.dart';
import 'package:flutter_ogreniyorum/constants/tasktype.dart';
import 'package:flutter_ogreniyorum/model/task.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {super.key, required this.task, required this.onTaskStatusChanged});
  final Task task;
  final VoidCallback onTaskStatusChanged;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.task.type == TaskType.note
                ? Image.asset("lib/assets/images/category1.png")
                : widget.task.type == TaskType.calendar
                    ? Image.asset("lib/assets/images/category2.png")
                    : Image.asset("lib/assets/images/category3.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.title,
                    style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  Text(
                    widget.task.description,
                    style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
            Checkbox(
                value: widget.task.isCompleted,
                onChanged: (val) {
                  setState(() {
                    widget.task.isCompleted = val!;
                    widget.onTaskStatusChanged();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
