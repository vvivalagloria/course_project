import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/todo.dart';

const String TODO_COLLECTION = 'todos';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService() {
    _todosRef = _firestore
        .collection(TODO_COLLECTION)
        .withConverter<Todo>(
      fromFirestore: (snap, _) => Todo.fromJson(snap.data()!),
      toFirestore: (todo, _) => todo.toJson(),
    );
  }

  Stream<QuerySnapshot<Todo>> getTodos(String userId) {
    return _todosRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdOn', descending: true)
        .snapshots();
  }

  Future<void> addTodo(Todo todo) => _todosRef.add(todo);

  Future<void> updateTodo(String id, Todo todo) =>
      _todosRef.doc(id).update(todo.toJson());

  Future<void> deleteTodo(String id) =>
      _todosRef.doc(id).delete();
}