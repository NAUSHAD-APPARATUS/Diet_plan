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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Health_Conditions());
}

class Health_Conditions extends StatelessWidget {
  const Health_Conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Health_ConditionsScreen(),
    );
  }
}

class Health_ConditionsScreen extends StatefulWidget {
  const Health_ConditionsScreen({super.key});

  @override
  State<Health_ConditionsScreen> createState() => _Health_ConditionsScreenState();
}

class _Health_ConditionsScreenState extends State<Health_ConditionsScreen> {
  // options list
  final List<String> _options = [
    'Diabetes',
    'Hypertension',
    'Thyroid',
    'PCOS / PCOD',
    'Digestive Issues',
    'Food Allergies (nuts, dairy, etc.)',
    'None of These',
    'Others',
  ];

  late final Map<String, bool> _selected;
  final TextEditingController others = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selected = { for (final o in _options) o: false };
  }

  @override
  void dispose() {
    others.dispose();
    super.dispose();
  }

  bool get _anySelected => _selected.values.any((v) => v == true);
  bool get _othersSelected => _selected['Others'] ?? false;

  void _onCheckboxChanged(String label, bool? value) {
    final newVal = value ?? false;
    setState(() {
      if (label == 'None of These') {
        if (newVal) {
          // check None -> clear everything else
          for (final key in _selected.keys) {
            _selected[key] = key == 'None of These';
          }
          others.clear();
        } else {
          _selected['None of These'] = false;
        }
        return;
      }

      // if checking any option while None is checked -> uncheck None
      if (newVal && (_selected['None of These'] ?? false)) {
        _selected['None of These'] = false;
      }

      if (label == 'Others') {
        _selected['Others'] = newVal;
        if (!newVal) others.clear();
        return;
      }

      _selected[label] = newVal;
    });
  }

  void _onContinue() {
    if (!_anySelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one condition')),
      );
      return;
    }

    if (_othersSelected && others.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please specify the 'Others' field")),
      );
      return;
    }

    // proceed
    Navigator.push(context, MaterialPageRoute(builder: (_) => const GetStartedScreen()));
  }

  // pill-style row but with a circular checkbox on right
  Widget _optionTile(String label) {
    final isSelected = _selected[label] ?? false;

    return GestureDetector(
      onTap: () => _onCheckboxChanged(label, !(isSelected)),
      child: Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),

            // circular checkbox (styled)
            SizedBox(
              width: 32,
              height: 32,
              child: Theme(
                data: Theme.of(context).copyWith(
                  // ensure checkbox uses our colors
                  unselectedWidgetColor: isSelected ? Colors.white : Colors.grey.shade600,
                ),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (v) => _onCheckboxChanged(label, v),
                  shape: const CircleBorder(), // circular checkbox
                  side: BorderSide(color: isSelected ? Colors.white : Colors.grey.shade600),
                  activeColor: isSelected ? Colors.white : AppColors.primary,
                  checkColor: isSelected ? AppColors.primary : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


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
                  "Select your Health Conditions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),

                // options (keeps original stacked look)
                _optionTile('Diabetes'),
                const SizedBox(height: 12),
                _optionTile('Hypertension'),
                const SizedBox(height: 12),
                _optionTile('Thyroid'),
                const SizedBox(height: 12),
                _optionTile('PCOS / PCOD'),
                const SizedBox(height: 12),
                _optionTile('Digestive Issues'),
                const SizedBox(height: 12),
                _optionTile('Food Allergies (nuts, dairy, etc.)'),
                const SizedBox(height: 12),
                _optionTile('None of These'),
                const SizedBox(height: 20),

                // Others text field enabled only when Others selected
                TextField(
                  keyboardType: TextInputType.text,
                  controller: others,

                  decoration: InputDecoration(
                    hintText: "Describe any other conditions",
                    labelText: 'Others',
                    labelStyle: const TextStyle(color: Colors.grey),
                    floatingLabelStyle: TextStyle(color: AppColors.primary),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 115, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      // If no condition selected -> show the specific message
                      if (!_anySelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select above health conditions')),
                        );
                        return;
                      }

                      // If Others is selected, require the text
                      if (_othersSelected && others.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please specify the 'Others' field")),
                        );
                        return;
                      }

                      // All good -> navigate
                      _onContinue();
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
