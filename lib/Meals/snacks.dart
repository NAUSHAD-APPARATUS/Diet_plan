// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diet_plan_app/firebase_options.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF00AF54);
  static const bgColor = Color(0xFFececec);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const snacks());
}

class snacks extends StatelessWidget {
  const snacks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const snacksScreen(),
    );
  }
}

class snacksScreen extends StatefulWidget {
  const snacksScreen({super.key});

  @override
  State<snacksScreen> createState() => _snacksScreenState();
}

class _snacksScreenState extends State<snacksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Braekfast"),
      ),

    );
  }
}