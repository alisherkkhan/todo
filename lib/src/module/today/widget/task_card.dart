import 'package:flutter/material.dart';
import 'package:todo/src/core/theme/app_colors.dart';
import 'package:todo/src/core/theme/app_text.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? date;
  final VoidCallback? onTap;
  final VoidCallback? toggle;
  final bool done;

  const TaskCard({
    super.key,
    required this.title,
    this.date,
    this.onTap,
    this.toggle,
    this.done = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: toggle,
        icon: Icon(
          done ? Icons.check_circle : Icons.radio_button_unchecked,
          color: done ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.taskTitle.copyWith(
          decoration: done ? TextDecoration.lineThrough : null,
          color: done ? AppColors.textSecondary : null,
        ),
      ),
      subtitle:
          date != null
              ? Text(
                date!,
                style: AppTextStyles.taskDate.copyWith(
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              )
              : null,
      onTap: onTap,
    );
  }
}
