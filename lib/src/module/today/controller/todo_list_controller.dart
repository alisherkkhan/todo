import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/src/data/todos/database.dart';
import 'package:todo/src/data/todos/provider.dart';

part 'todo_list_controller.g.dart';

@Riverpod(keepAlive: false)
class TodoListController extends _$TodoListController {
  @override
  Stream<List<Todo>> build() {
    final db = ref.read(dbProvider);
    return db.watchTodos();
  }

  Future<void> addTodo({
    required String title,
    required String description,
    String? date,
    String? imagePath,
  }) async {
    final db = ref.read(dbProvider);
    await db.insertTodo(
      TodosCompanion.insert(
        title: title,
        description: description,
        date: Value(date),
        imagePath: Value(imagePath),
      ),
    );
  }

  Future<void> toggleDone(Todo todo) async {
    final db = ref.read(dbProvider);
    await db.updateTodo(todo.copyWith(done: !todo.done));
  }

  Future<void> deleteTodo(int id) async {
    final db = ref.read(dbProvider);
    await db.deleteTodo(id);
  }
}
