import 'dart:math';

import 'package:diet_plan_app/Get_Started.dart';
import 'package:diet_plan_app/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diet_plan_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF00AF54);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Third());
}

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ThirdScreen(),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() =>
      _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ThirdScreen"),
      ),

    );
  }
}
