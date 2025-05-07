import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/core/theme/app_colors.dart';
import 'package:todo/src/core/theme/app_text.dart';
import 'package:todo/src/module/today/controller/todo_list_controller.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final copied = await File(
      picked.path,
    ).copy(p.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg'));

    setState(() {
      _imagePath = copied.path;
    });
  }

  Future<void> _saveTodo() async {
    final title = _titleController.text.trim();
    final desciption = _descriptionController.text.trim();
    if (title.isEmpty) return;

    await ref
        .read(todoListControllerProvider.notifier)
        .addTodo(
          title: title,
          description: desciption,
          date: DateTime.now().toIso8601String().substring(0, 10),
          imagePath: _imagePath,
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Новая задача', style: AppTextStyles.sectionTitle),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _saveTodo),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Название',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              border: InputBorder.none,
            ),
            style: AppTextStyles.taskTitle,
            maxLines: null,
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Описание',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              border: InputBorder.none,
            ),
            style: AppTextStyles.taskTitle,
            maxLines: null,
          ),
          const SizedBox(height: 16),
          if (_imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(_imagePath!),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.photo),
            label: const Text('Добавить фото'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
