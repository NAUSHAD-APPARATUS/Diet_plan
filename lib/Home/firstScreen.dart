import 'dart:math';

import 'package:diet_plan_app/Get_Started.dart';
import 'package:diet_plan_app/Home/today.dart';
import 'package:diet_plan_app/Home/weekly.dart';
import 'package:diet_plan_app/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diet_plan_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'mothly.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF00AF54);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const first());
}

class first extends StatelessWidget {
  const first({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const firstScreen(),
    );
  }
}

class firstScreen extends StatefulWidget {
  const firstScreen({super.key});

  @override
  State<firstScreen> createState() =>
      _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {

  int selectedIndex = 0;

  final tabs = ["Today", "Weekly", "Monthly"];
  final List<Widget> screens = [
    todayScreen(),
    weeklyScreen(),
    monthlyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset("assets/images/logo.webp"),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 30, left: 15, right: 15),
            width: double.infinity,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/banner_Home.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tabs.length, (index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(color: AppColors.primary)
                        : null,
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: screens[selectedIndex],
          ),
        ],

      ),
    );
  }
}
