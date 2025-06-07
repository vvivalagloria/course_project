// database_server.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/todo.dart';

const String TODO_COLLECTION_REF = "todos";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService() {
    _todosRef = _firestore
        .collection(TODO_COLLECTION_REF)
        .withConverter<Todo>(
      fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
      toFirestore: (todo, _) => todo.toJson(),
    );
  }

  /// Now accepts the current user's UID and only returns that user's todos.
  Stream<QuerySnapshot<Todo>> getTodos(String userId) {
    return _todosRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdOn', descending: true) // optional: order by date
        .snapshots();
  }

  Future<void> addTodo(Todo todo) async {
    await _todosRef.add(todo);
  }

  Future<void> updateTodo(String todoId, Todo todo) {
    return _todosRef.doc(todoId).update(todo.toJson());
  }

  Future<void> deleteTodo(String todoId) {
    return _todosRef.doc(todoId).delete();
  }
}
