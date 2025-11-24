import 'dart:math';

import 'package:diet_plan_app/Goal_Selection.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Tell_Us());
}

class Tell_Us extends StatelessWidget {
  const Tell_Us({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Tell_UsScreen(),
    );
  }
}

class Tell_UsScreen extends StatefulWidget {
  const Tell_UsScreen({super.key});

  @override
  State<Tell_UsScreen> createState() => _Tell_UsScreenState();
}

class _Tell_UsScreenState extends State<Tell_UsScreen> {
  final name = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();

  String? selectedGender; // only ONE string used for everything

  @override
  void dispose() {
    name.dispose();
    weight.dispose();
    height.dispose();
    super.dispose();
  }

  void _tryContinue() {
    final userName = name.text.trim();
    final userHeight = height.text.trim();
    final userWeight = weight.text.trim();

    if (userName.isEmpty ||
        userWeight.isEmpty ||
        userHeight.isEmpty ||
        selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields", style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => const GoalScreen()));
  }

  Widget _radioOption(String label) {
    return InkWell(
      onTap: () {
        setState(() => selectedGender = label);
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Radio<String>(
              value: label,
              groupValue: selectedGender,
              onChanged: (v) {
                setState(() => selectedGender = v);
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final isFormValid =
        name.text.trim().isNotEmpty &&
            weight.text.trim().isNotEmpty &&
            height.text.trim().isNotEmpty &&
            selectedGender != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 340,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Tell us About Yourself",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Full Name
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: AppColors.primary),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Weight & Height
                  Row(
                    children: [
                      Expanded(
                        child:  TextField(
                          controller: weight,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Weight(kg)',
                            labelStyle: const TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: AppColors.primary),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.primary,width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey,),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: height,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Height(cm)',
                            labelStyle: const TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: AppColors.primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.primary,width:2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Gender Selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),

                    ),
                    child: Column(
                      children: [
                        _radioOption("Male"),
                        const Divider(height: 1),
                        _radioOption("Female"),
                        const Divider(height: 1),
                        _radioOption("Others"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Continue Button

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 125,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: isFormValid
                          ? _tryContinue
                          : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please fill all fields")),
                        );
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
