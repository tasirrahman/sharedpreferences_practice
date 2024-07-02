import 'package:flutter/material.dart';
import 'package:sharedpreferences_practice/models/todo_item.dart';
import 'package:sharedpreferences_practice/services/shared_prefs_service.dart';
import 'package:sharedpreferences_practice/widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  HomeScreen({required this.onThemeChanged, required this.isDarkMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPrefsService _prefsService = SharedPrefsService();
  List<TodoItem> _todos = [];
  bool _isDarkMode = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final todos = await _prefsService.loadTodoList();
    final isDarkMode = await _prefsService.loadThemeMode();
    setState(() {
      _todos = todos;
      _isDarkMode = isDarkMode;
    });
    widget.onThemeChanged(_isDarkMode);
  }

  Future<void> _saveTodos() async {
    await _prefsService.saveTodoList(_todos);
  }

  void _addTodo() {
    final newTodo = TodoItem(title: _controller.text);
    setState(() {
      _todos.add(newTodo);
    });
    _controller.clear();
    _saveTodos();
  }

  void _toggleComplete(TodoItem todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
    _saveTodos();
  }

  void _deleteTodo(TodoItem todo) {
    setState(() {
      _todos.remove(todo);
    });
    _saveTodos();
  }

  Future<void> _toggleThemeMode() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    widget.onThemeChanged(_isDarkMode);
    await _prefsService.saveThemeMode(_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: _toggleThemeMode,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Add a new task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text('Add ToDo'),
          ),
          Expanded(
            child: TodoList(
              todos: _todos,
              onToggleComplete: _toggleComplete,
              onDelete: _deleteTodo,
            ),
          ),
        ],
      ),
    );
  }
}
