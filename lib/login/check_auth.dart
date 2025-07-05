import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/app_screen.dart';
import 'package:project_plugin/login/login_screen.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const AppScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
