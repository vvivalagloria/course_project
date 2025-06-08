import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/todo.dart';
import '../services/database_service.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final String docId;
  const TodoListItem({required this.todo, required this.docId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.secondaryContainer,
      title: Text(todo.task),
      subtitle:
      Text(DateFormat('dd-MM-yyyy h:mm a').format(todo.updatedOn.toDate())),
      trailing: Checkbox(
        value: todo.isDone,
        onChanged: (_) async {
          final updated = todo.copyWith(isDone: !todo.isDone, updatedOn: Timestamp.now());
          try {
            await DatabaseService().updateTodo(docId, updated);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Update failed: $e')),
            );
          }
        },
      ),
      onLongPress: () async {
        try {
          await DatabaseService().deleteTodo(docId);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Delete failed: $e')),
          );
        }
      },
    );
  }
}