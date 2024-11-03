import 'package:flutter/material.dart';
import 'task_items.dart'; // Adjust the path according to your project structure

class TaskTabs extends StatelessWidget {
  final List<TaskItem> todayTasks;
  final List<TaskItem> weeklyTasks;
  final List<TaskItem> monthlyTasks;

  TaskTabs({
    required this.todayTasks,
    required this.weeklyTasks,
    required this.monthlyTasks,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Today's Tasks"),
              Tab(text: 'Weekly Tasks'),
              Tab(text: 'Monthly Tasks'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TaskList(tasks: todayTasks),
                TaskList(tasks: weeklyTasks),
                TaskList(tasks: monthlyTasks),
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

  TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskItem task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            task.description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            task.date,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
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
