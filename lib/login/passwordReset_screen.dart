import 'package:flutter/material.dart';

class PasswordresetScreen extends StatelessWidget {
  const PasswordresetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("돌아가기"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "아직 기능 개발 중입니다.",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
