import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({
    required this.name,
    this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> Tasks = [];
  TextEditingController TaskController = TextEditingController();

  void _addTask() {
    if (TaskController.text.isNotEmpty) {
      setState(() {
        Tasks.add(Task(name: TaskController.text));
        TaskController.clear();
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      Tasks[index].isCompleted = !Tasks[index].isCompleted;
    });
  }

  void _removeTask(int index) {
    setState(() {
      Tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: TaskController,
              decoration: InputDecoration(
                labelText: 'Enter task name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: Tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      Tasks[index].name,
                      style: TextStyle(
                        decoration: Tasks[index].isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: Tasks[index].isCompleted,
                      onChanged: (bool? value) {
                        _toggleTaskCompletion(index);
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}