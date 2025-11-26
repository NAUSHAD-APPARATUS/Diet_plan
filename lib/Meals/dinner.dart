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
  runApp(const dinner());
}

class dinner extends StatelessWidget {
  const dinner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const dinnerScreen(),
    );
  }
}

class dinnerScreen extends StatefulWidget {
  const dinnerScreen({super.key});

  @override
  State<dinnerScreen> createState() => _dinnerScreenState();
}

class _dinnerScreenState extends State<dinnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Dinner"),
      ),

    );
  }
}