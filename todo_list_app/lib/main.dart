import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/task.dart';

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'To-Do List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: TodoHomePage(),
        );
      },
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final box = Hive.box<Task>('tasks');
    setState(() {
      _tasks = box.values.toList()
        ..sort((a, b) => a.done == b.done ? 0 : (a.done ? 1 : -1));
    });
  }

  void _addTask() {
    String task = _controller.text.trim();
    if (task.isNotEmpty) {
      final newTask = Task(title: task);
      final box = Hive.box<Task>('tasks');
      box.add(newTask);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task added!')),
      );
      _controller.clear();
      _loadTasks();
    }
  }

  void _toggleComplete(int index) {
    final task = _tasks[index];
    task.done = !task.done;
    task.save();
    _loadTasks();
  }

  void _editTask(BuildContext context, Task task) {
    final controller = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                task.title = controller.text.trim();
                task.save();
                Navigator.pop(context);
                _loadTasks();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    final task = _tasks[index];
    task.delete();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To-Do List'),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              setState(() {
                themeNotifier.value =
                themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (_, index) {
                final task = _tasks[index];
                return Card(
                  child: ListTile(
                    onLongPress: () => _editTask(context, _tasks[index]),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      task.created.toString().substring(0, 16),
                      style: TextStyle(fontSize: 12),
                    ),
                    leading: Checkbox(
                      value: task.done,
                      onChanged: (_) => _toggleComplete(index),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}