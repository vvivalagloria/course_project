<<<<<<< Updated upstream
// home_page.dart
=======
import 'dart:async';
>>>>>>> Stashed changes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../modules/todo.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/todo_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
<<<<<<< Updated upstream
  final TextEditingController _textEditingController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
=======
  final _db = DatabaseService();
  final _auth = AuthService();
  late final StreamSubscription _authSub;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    // listen for sign-out and send user back to login
    _authSub = _auth.authStateChanges.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser!;
    return Scaffold(
<<<<<<< Updated upstream
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _user != null
          ? Column(
        children: [
          _userInfo(),
          _buildUI(),
        ],
      )
          : Center(child: _googleSignInButton()),
      floatingActionButton: _user != null
          ? FloatingActionButton(
        onPressed: _displayTextInputDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text("Todo", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildUI() {
    // We only get here if _user != null
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Todo>>(
        stream: _databaseService.getTodos(_user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text("Add a todo!"));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final todoDoc = docs[index];
              final todo = todoDoc.data();
              final todoId = todoDoc.id;
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  tileColor:
                  Theme.of(context).colorScheme.primaryContainer,
                  title: Text(todo.task),
                  subtitle: Text(
                    DateFormat("dd-MM-yyyy h:mm a")
                        .format(todo.updatedOn.toDate()),
                  ),
                  trailing: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      final updatedTodo = todo.copyWith(
                        isDone: !todo.isDone,
                        updatedOn: Timestamp.now(),
                      );
                      _databaseService.updateTodo(todoId, updatedTodo);
                    },
                  ),
                  onLongPress: () {
                    _databaseService.deleteTodo(todoId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          buttonType: ButtonType.google,
          onPressed: _handleUserSignIn,
        ),
      ),
    );
  }

  void _handleUserSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  Widget _userInfo() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(_user!.photoURL!),
          ),
          const SizedBox(height: 8),
          Text(_user!.displayName ?? "",
              style: const TextStyle(fontSize: 16)),
          Text(_user!.email!),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: _auth.signOut,
            child: const Text("Sign Out"),
          )
        ],
      ),
    );
  }

  void _displayTextInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Todo..."),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Ok'),
              onPressed: () {
                final newTodo = Todo(
                  task: _textEditingController.text,
                  isDone: false,
                  createdOn: Timestamp.now(),
                  updatedOn: Timestamp.now(),
                  userId: _user!.uid, // PASS the current user's UID here
                );
                _databaseService.addTodo(newTodo);
                Navigator.pop(context);
                _textEditingController.clear();
              },
            ),
          ],
        );
      },
=======
      appBar: AppBar(
        title: const Text('Your Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.signOut(),
          )
        ],
      ),
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Todo>>(
              stream: _db.getTodos(user.uid),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snap.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('No todos yet'));
                }
                return ListView(
                  children: docs
                      .map((doc) => TodoListItem(
                    todo: doc.data(),
                    docId: doc.id,
                  ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/edit'),
        child: const Icon(Icons.add),
      ),
>>>>>>> Stashed changes
    );
  }
}
