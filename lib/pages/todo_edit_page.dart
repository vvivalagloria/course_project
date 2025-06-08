import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../modules/todo.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

class TodoEditPage extends StatefulWidget {
  final Todo? existing;
  final String? existingDocId;
  const TodoEditPage({this.existing, this.existingDocId, Key? key})
      : super(key: key);

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  final _taskCtrl = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      _taskCtrl.text = widget.existing!.task;
    }
  }

  Future<void> _save() async {
    final text = _taskCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _loading = true);
    final now = Timestamp.now();
    final user = AuthService().currentUser!;
    final todo = widget.existing != null
        ? widget.existing!.copyWith(task: text, updatedOn: now)
        : Todo(
      task: text,
      isDone: false,
      createdOn: now,
      updatedOn: now,
      userId: user.uid,
    );
    try {
      if (widget.existing != null) {
        await DatabaseService().updateTodo(widget.existingDocId!, todo);
      } else {
        await DatabaseService().addTodo(todo);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? 'New Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _taskCtrl,
              decoration: const InputDecoration(labelText: 'Task'),
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}