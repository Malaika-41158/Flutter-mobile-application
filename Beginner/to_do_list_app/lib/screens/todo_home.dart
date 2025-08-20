import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_input.dart';
import '../widgets/task_item.dart';

enum TaskFilter { all, active, completed }

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  TaskFilter _filter = TaskFilter.all;

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a.isDone == b.isDone) {
        return b.createdAt.compareTo(a.createdAt);
      }
      return a.isDone ? 1 : -1;
    });
  }

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      final newTask = Task(title: _controller.text);
      _tasks.insert(0, newTask);
      _controller.clear();
      _sortTasks();

      final newIndex = _tasks.indexOf(newTask);
      _listKey.currentState?.insertItem(newIndex);
    });
  }

  void _toggleDone(Task task) {
    setState(() {
      task.isDone = !task.isDone;
      _sortTasks();
    });
  }

  void _deleteTask(Task task) {
    final index = _tasks.indexOf(task);
    if (index == -1) return;

    final removedTask = _tasks[index];

    setState(() {
      _tasks.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
            (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: TaskItem(
            task: removedTask,
            onToggle: () => _toggleDone(removedTask),
            onDelete: () {},
          ),
        ),
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  List<Task> _getFilteredTasks() {
    switch (_filter) {
      case TaskFilter.active:
        return _tasks.where((task) => !task.isDone).toList();
      case TaskFilter.completed:
        return _tasks.where((task) => task.isDone).toList();
      case TaskFilter.all:
        return _tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _getFilteredTasks();

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: Column(
        children: [
          TaskInput(
            controller: _controller,
            onAdd: _addTask,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  label: const Text("All"),
                  selected: _filter == TaskFilter.all,
                  onSelected: (_) => setState(() => _filter = TaskFilter.all),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Active"),
                  selected: _filter == TaskFilter.active,
                  onSelected: (_) => setState(() => _filter = TaskFilter.active),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Completed"),
                  selected: _filter == TaskFilter.completed,
                  onSelected: (_) => setState(() => _filter = TaskFilter.completed),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredTasks.isEmpty
                ? const Center(child: Text("No tasks yet!"))
                : AnimatedList(
              key: _listKey,
              initialItemCount: _tasks.length, // ✅ not filteredTasks
              itemBuilder: (context, index, animation) {
                final task = _tasks[index]; // ✅ always use source of truth
                if (_filter == TaskFilter.active && task.isDone) return const SizedBox.shrink();
                if (_filter == TaskFilter.completed && !task.isDone) return const SizedBox.shrink();

                return SizeTransition(
                  sizeFactor: animation,
                  child: TaskItem(
                    task: task,
                    onToggle: () => _toggleDone(task),
                    onDelete: () => _deleteTask(task),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}