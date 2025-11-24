
import 'dart:math';

import 'package:diet_plan_app/Health_Coditions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diet_plan_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class AppColors {
  AppColors._();
  static const primary = Color(0xFF00AF54);
}


class Diet_preferenceScreen extends StatefulWidget {
  const Diet_preferenceScreen({super.key});

  @override
  State<Diet_preferenceScreen> createState() => _Diet_preferenceScreenState();
}

class _Diet_preferenceScreenState extends State<Diet_preferenceScreen> {
  String? selectedDiet;


  @override
  void dispose() {
    super.dispose();
  }


  Widget _diet(String label) {
    final bool isSelected = selectedDiet == label;
    return GestureDetector(
      onTap: () => setState(() => selectedDiet = label),
      child: Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    final bool selectionEmpty = (selectedDiet?.trim().isEmpty ?? false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Select your Diet Preference",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                _diet('Veg'),
                const SizedBox(height: 12),
                _diet('Non-Veg'),
                const SizedBox(height: 12),
                _diet('Vegan'),
                const SizedBox(height: 12),
                _diet('Eggetarian'),
                const SizedBox(height: 12),
                _diet('Keto / Low-Carb'),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 115,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: selectionEmpty ? null : () {
                      if (selectedDiet == null || selectedDiet!.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please fill all fields",
                              style: TextStyle(color: Colors.white),),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Health_ConditionsScreen()),
                      );
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}