import 'package:flutter/material.dart';
import 'package:to_do_list_pro/data/service/prefference.dart';
import 'package:to_do_list_pro/models/task.dart';
import '../widgets/add_task_widget.dart';
import '../widgets/task_tile.dart';
import '../widgets/edit_task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  List<Task> todo = [];
  ValueNotifier<bool> isDark = ValueNotifier(false);
  final PreferenceService prefs = PreferenceService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    todo = await prefs.loadTasks();
    isDark.value = await prefs.loadTheme();

    setState(() {});
  }

  Future<void> addTask() async {
    String task = controller.text;
    if (task.isNotEmpty) {
      setState(() {
        todo.add(Task(title: task, isChecked: false));
      });
      controller.clear();
      await prefs.saveTasks(todo);
    }
  }

  Future<void> removeTask(int index) async {
    setState(() {
      todo.removeAt(index);
    });

    await prefs.saveTasks(todo);
  }

  Future<void> toggleCheck(bool? value, int index) async {
    setState(() {
      todo[index].isChecked = value!;
    });

    await prefs.saveTasks(todo);
  }

  Future<void> editTask(int index, String newTitle) async {
    setState(() {
      todo[index].title = newTitle;
    });
    await prefs.saveTasks(todo);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, value, child) {
        return Theme(
          data: ThemeData(
            brightness: value ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text('To-Do List'),
              actions: [
                IconButton(
                  onPressed: () async {
                    isDark.value = !isDark.value;
                    await prefs.saveTheme(isDark.value);
                  },
                  icon: Icon(value ? Icons.light_mode : Icons.dark_mode),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  AddTaskWidget(controller: controller, onAdd: addTask),
                  SizedBox(height: 23.0),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          task: todo[index],
                          onCheck: (value) => toggleCheck(value, index),
                          onDelete: () => removeTask(index),
                          onEdit: () {
                            final editController = TextEditingController(
                              text: todo[index].title,
                            );

                            showDialog(
                              context: context,
                              builder: (context) {
                                return EditTaskWidget(
                                  controller: editController,
                                  onSave: () {
                                    editTask(index, editController.text);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
