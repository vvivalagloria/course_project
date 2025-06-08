// todo.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String task;
  final bool isDone;
  final Timestamp createdOn;
  final Timestamp updatedOn;
<<<<<<< Updated upstream
  final String userId;       // NEW: store the UID of the user who owns this todo
=======
  final String userId;
>>>>>>> Stashed changes

  Todo({
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
<<<<<<< Updated upstream
    required this.userId,     // NEW
=======
    required this.userId,
>>>>>>> Stashed changes
  });

  // Modify fromJson to read 'userId'
  Todo.fromJson(Map<String, Object?> json)
      : this(
    task: json['task']! as String,
    isDone: json['isDone']! as bool,
    createdOn: json['createdOn']! as Timestamp,
    updatedOn: json['updatedOn']! as Timestamp,
<<<<<<< Updated upstream
    userId: json['userId']! as String,  // NEW
=======
    userId: json['userId']! as String,
>>>>>>> Stashed changes
  );

  Todo copyWith({
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
<<<<<<< Updated upstream
    String? userId,         // NEW
=======
    String? userId,
>>>>>>> Stashed changes
  }) {
    return Todo(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
<<<<<<< Updated upstream
      userId: userId ?? this.userId,  // NEW
=======
      userId: userId ?? this.userId,
>>>>>>> Stashed changes
    );
  }

  Map<String, Object?> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
<<<<<<< Updated upstream
      'userId': userId,      // NEW
=======
      'userId': userId,
>>>>>>> Stashed changes
    };
  }
}
