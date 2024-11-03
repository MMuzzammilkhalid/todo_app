import 'package:flutter/material.dart';
import 'addScreen.dart';
import 'task_items.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskItem> todayTasks = [];
  List<TaskItem> weeklyTasks = [];
  List<TaskItem> monthlyTasks = [];

  void _addNewTask(TaskItem task) {
    setState(() {
      todayTasks.add(task);
    });
  }

  void _editTask(int index, TaskItem updatedTask) {
    setState(() {
      todayTasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      todayTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 120, 188),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 120, 188),
        elevation: 0,
        title: const Text(
          'Task Manager',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/image/profile.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Priority Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                PriorityTaskCard(
                  timeAgo: '2 hours Ago',
                  title: 'Mobile App UI Design',
                  subtitle: 'Using Figma and other tools',
                  icon: Icons.phone_android_sharp,
                ),
                SizedBox(width: 5),
                PriorityTaskCard(
                  timeAgo: '2 hours Ago',
                  title: 'Capture Sun Rise Shots',
                  subtitle: 'Complete GuruShot Challenges',
                  icon: Icons.camera_alt_outlined,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'My Tasks',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TaskTabs(
                todayTasks: todayTasks,
                weeklyTasks: weeklyTasks,
                monthlyTasks: monthlyTasks,
                onEdit: _editTask,
                onDelete: _deleteTask,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          ).then((newTask) {
            if (newTask != null) {
              _addNewTask(newTask);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PriorityTaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData? icon; // Optional icon parameter

  const PriorityTaskCard({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.icon, // Add an optional icon parameter
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack( // Use a Stack to position the icon
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeAgo,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            if (icon != null) // Show icon only if provided
              Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TaskTabs extends StatelessWidget {
  final List<TaskItem> todayTasks;
  final List<TaskItem> weeklyTasks;
  final List<TaskItem> monthlyTasks;
  final Function(int, TaskItem) onEdit;
  final Function(int) onDelete;

  const TaskTabs({
    required this.todayTasks,
    required this.weeklyTasks,
    required this.monthlyTasks,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.yellow,
            tabs: const [
              Tab(text: 'Today’s Task'),
              Tab(text: 'Weekly Task'),
              Tab(text: 'Monthly Task'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TaskList(tasks: todayTasks, onEdit: onEdit, onDelete: onDelete),
                TaskList(tasks: weeklyTasks, onEdit: onEdit, onDelete: onDelete),
                TaskList(tasks: monthlyTasks, onEdit: onEdit, onDelete: onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<TaskItem> tasks;
  final Function(int, TaskItem) onEdit;
  final Function(int) onDelete;

  const TaskList({required this.tasks, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: tasks[index],
          onEdit: () {
            _showEditDialog(context, tasks[index], index, onEdit);
          },
          onDelete: () {
            onDelete(index);
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, TaskItem task, int index, Function(int, TaskItem) onEdit) {
    final TextEditingController titleController = TextEditingController(text: task.title);
    final TextEditingController descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Title and Description cannot be empty')),
                  );
                  return; // Don't proceed with saving
                }

                String newTitle = titleController.text;
                String newDescription = descriptionController.text;

                TaskItem updatedTask = TaskItem(
                  title: newTitle,
                  description: newDescription,
                  date: task.date,
                  status: task.status,
                );

                onEdit(index, updatedTask); // Call the edit function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskItem task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({required this.task, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // Assuming task.date is in the format "YYYY-MM-DD HH:MM:SS"
    DateTime taskDateTime = DateTime.parse(task.date); // Parse the date string
    String hourString = taskDateTime.hour.toString().padLeft(2, '0'); // Get hours as string

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4), // Space between title and description
                Text(
                  task.description, // Displaying the description here
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54, // Lighter color for description
                  ),
                ),
                Text(task.date,
                  // Displaying the hours extracted from date
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          Text(
            task.status == 'to do' ? 'To do' : 'Done',
            style: TextStyle(
              fontSize: 14,
              color: task.status == 'to do' ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
