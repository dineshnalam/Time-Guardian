import 'package:firebase_auth/firebase_auth.dart';

class Task {
  final String taskId;
  final String domain;
  final String date;
  final String taskText;
  final String userId;
  String status;
  final int priority;
  final String start;  // new property
  final String end;  // new property

  Task({
    required this.taskId,
    required this.domain,
    required this.date,
    required this.taskText,
    required this.userId,
    required this.status,
    required this.priority,
    required this.start,  // new property
    required this.end,  // new property
  });

  // Convert a Task object into a Map
  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'domain': domain,
        'date': date,
        'taskText': taskText,
        'userId': userId,
        'status': status,
        'priority': priority,
        'start': start,  // new property
        'end': end,  // new property
      };

  // Create a Task object from a Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      domain: json['domain'],
      date: json['date'],
      taskText: json['taskText'],
      userId: json['userId'],
      status: json['status'],
      priority: json['priority'],
      start: json['start'],  // new property
      end: json['end'],  // new property
    );
  }
}

List<Task> getDummyTasks() {
  return List<Task>.generate(5, (index) {
    return Task(
      taskId: 'task${index + 1}',
      domain: 'domain${index + 1}',
      date: DateTime.now().toString(),
      taskText: 'This is task ${index + 1}',
      userId: FirebaseAuth.instance.currentUser!.uid,
      status: 'status${index + 1}',
      priority: index % 2,  // priority will be either 0 or 1
      start: 'start${index + 1}',  // new property
      end: 'end${index + 1}',  // new property
    );
  });
}