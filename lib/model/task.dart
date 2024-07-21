import 'package:flutter_ogreniyorum/constants/tasktype.dart';

class Task {
  final TaskType type;
  final String title;
  final String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.type,
  });
}
