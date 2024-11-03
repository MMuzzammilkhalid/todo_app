class TaskItem {
  final String title;
  final String description; // Ensure this field is included
  final String date;
  final String status;

  TaskItem({
    required this.title,
    required this.description, // Include this in the constructor
    required this.date,
    required this.status,
  });
}
