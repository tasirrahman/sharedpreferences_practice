import 'package:flutter/material.dart';
import 'package:sharedpreferences_practice/models/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoItem> todos;
  final Function(TodoItem) onToggleComplete;
  final Function(TodoItem) onDelete;

  TodoList({
    required this.todos,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              onToggleComplete(todo);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(todo);
            },
          ),
        );
      },
    );
  }
}
