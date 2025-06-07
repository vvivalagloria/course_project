// todo.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String task;
  final bool isDone;
  final Timestamp createdOn;
  final Timestamp updatedOn;
  final String userId;       // NEW: store the UID of the user who owns this todo

  Todo({
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
    required this.userId,     // NEW
  });

  // Modify fromJson to read 'userId'
  Todo.fromJson(Map<String, Object?> json)
      : this(
    task: json['task']! as String,
    isDone: json['isDone']! as bool,
    createdOn: json['createdOn']! as Timestamp,
    updatedOn: json['updatedOn']! as Timestamp,
    userId: json['userId']! as String,  // NEW
  );

  Todo copyWith({
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
    String? userId,         // NEW
  }) {
    return Todo(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      userId: userId ?? this.userId,  // NEW
    );
  }

  Map<String, Object?> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'userId': userId,      // NEW
    };
  }
}
