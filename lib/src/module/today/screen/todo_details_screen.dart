import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/src/core/theme/app_colors.dart';
import 'package:todo/src/core/theme/app_text.dart';
import 'package:todo/src/data/todos/database.dart';
import 'package:todo/src/module/today/controller/todo_list_controller.dart';

class TodoDetailsScreen extends ConsumerWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todoListControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Детали задачи', style: AppTextStyles.sectionTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await notifier.deleteTodo(todo.id);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  todo.title,
                  style: AppTextStyles.taskTitle.copyWith(
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  todo.description,
                  style: AppTextStyles.taskTitle.copyWith(
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),

          if (todo.date != null)
            Text('Дата: ${todo.date}', style: AppTextStyles.taskDate),
          const SizedBox(height: 12),
          if (todo.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(todo.imagePath!),
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
        ],
      ),
    );
  }
}
