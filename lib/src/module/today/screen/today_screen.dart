import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/src/core/theme/app_colors.dart';
import 'package:todo/src/core/theme/app_text.dart';
import 'package:todo/src/module/today/controller/todo_list_controller.dart';
import 'package:todo/src/module/today/screen/add_todo_screen.dart';
import 'package:todo/src/module/today/screen/todo_details_screen.dart';
import 'package:todo/src/module/today/widget/task_card.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text('Сегодня', style: AppTextStyles.sectionTitle),
      ),
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddTodoScreen()));
          },
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 6,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
      backgroundColor: AppColors.white,
      body: todosAsync.when(
        data:
            (tasks) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(
                  title: task.title,
                  date: task.date,
                  done: task.done,
                  // imagePath: task.imagePath,
                  toggle: () {
                    ref
                        .read(todoListControllerProvider.notifier)
                        .toggleDone(task);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoDetailsScreen(todo: task),
                      ),
                    );
                  },
                );
              },
              separatorBuilder:
                  (_, __) => Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: AppColors.divider,
                  ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
