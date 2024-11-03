import 'package:flutter/material.dart';
import 'package:todo_app/addScreen.dart';














class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 120, 188), // Background color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 120, 188),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Notes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Have a great Day',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/image/profile.png'), // Profile picture
            ),
          ),
        ],
      ),
      body: 
     
      
      Padding(
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
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Column(children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '2 hours Ago',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 90),
                        Icon(
                          Icons.phone_android_sharp,
                          color: Colors.white,
                        )
                      ],
                    
                    ),
                    
                    Text('Mobile App UI Design',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17)),
                            SizedBox(height: 5),
                    Text(
                      'using Figma and other tools',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                ),



                const SizedBox(width: 5),
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:   const Column(children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '2 hours Ago',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 90),
                         Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        )
                      ],
                    
                    ),
                    
                    Text('Capture Sun Rise Shots',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17)),
                            SizedBox(height: 5),
                    Text(
                      'Complete GuruShot Challenges',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'My Tasks',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TaskTabs(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PriorityTaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String timeAgo;

  PriorityTaskCard({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
  });

  @override
  State<PriorityTaskCard> createState() => _PriorityTaskCardState();
}

class _PriorityTaskCardState extends State<PriorityTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.timeAgo,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskTabs extends StatefulWidget {
  @override
  _TaskTabsState createState() => _TaskTabsState();
}

class _TaskTabsState extends State<TaskTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.yellow,
          tabs: const [
            Tab(text: 'Today’s Task'),
            Tab(text: 'Weekly Task'),
            Tab(text: 'Monthly Task'),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              TaskList(tasks: [
                TaskItem(
                    title: 'Complete Assignment #2',
                    date: '13 September 2022',
                    status: 'to do'),
                TaskItem(
                    title: 'Submit Fee Challan',
                    date: '18 September 2022',
                    status: 'done'),
              ]),
              const Center(
                  child: Text('Weekly Tasks',
                      style: TextStyle(color: Colors.white))),
              const Center(
                  child: Text('Monthly Tasks',
                      style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ],
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

class TaskItem {
  final String title;
  final String date;
  final String status;

  TaskItem({required this.title, required this.date, required this.status});
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              Text(
                task.date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
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
