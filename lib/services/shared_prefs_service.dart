import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sharedpreferences_practice/models/todo_item.dart';

class SharedPrefsService {
  static const String todoListKey = 'todo_list';
  static const String themeModeKey = 'theme_mode';

  Future<void> saveTodoList(List<TodoItem> todos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todoStrings =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList(todoListKey, todoStrings);
  }

  Future<List<TodoItem>> loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList(todoListKey);
    if (todoStrings == null) return [];
    return todoStrings
        .map((todoStr) => TodoItem.fromJson(jsonDecode(todoStr)))
        .toList();
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeModeKey, isDarkMode);
  }

  Future<bool> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeModeKey) ?? false;
  }
}
