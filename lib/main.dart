import 'package:course_project/pages/home_page.dart';
import 'package:course_project/pages/login_page.dart';
import 'package:course_project/pages/todo_edit_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD2E0FB),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (ctx) => const SplashPage(),
        '/login': (ctx)  => const LoginPage(),
        '/home': (ctx)   => const HomePage(),
        '/edit': (ctx)   => const TodoEditPage(),
      },
    );
  }
}