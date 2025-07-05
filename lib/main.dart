import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_plugin/login/check_auth.dart';
import 'package:project_plugin/firebase_options.dart';

const List<String> list = <String>['서울특별시', '광주광역시'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instanceFor(app: Firebase.app());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CheckAuth(), debugShowCheckedModeBanner: false);
  }
}
