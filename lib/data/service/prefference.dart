import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_pro/models/task.dart';

class PreferenceService {
  // Save Tasks
  Future<void> saveTasks(List<Task> todo) async {
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode(todo.map((task) => task.toJson()).toList());

    await prefs.setString('todoList', data);
  }

  // Load Tasks
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString('todoList');

    if (data == null) return [];

    final List decoded = jsonDecode(data);

    return decoded.map((item) => Task.fromJson(item)).toList();
  }

  // Save Theme
  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDark', isDark);
  }

  // Load Theme
  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isDark') ?? false;
  }
}
