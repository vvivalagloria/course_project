import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _handleSignIn(BuildContext context) async {
    final auth = AuthService();
    try {
      await auth.signInWithGoogle();
      // once signed in, replace this page with HomePage
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SignInButton(
          buttonType: ButtonType.google,
          onPressed: () => _handleSignIn(context),
        ),
      ),
    );
  }
}
