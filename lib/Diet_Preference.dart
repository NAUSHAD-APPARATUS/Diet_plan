import 'package:flutter/material.dart';
import 'package:diet_plan_app/Health_Coditions.dart';

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
  final List<String> _options = [
    'Veg',
    'Non-Veg',
    'Vegan',
    'Eggetarian',
    'Keto / Low-Carb',
  ];

  late final Map<String, bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = {for (final o in _options) o: false};
  }

  bool get _anySelected => _selected.values.any((v) => v);

  void _onCheckboxChanged(String label, bool? value) {
    setState(() {
      _selected[label] = value ?? false;
    });
  }

  Widget _optionTile(String label) {
    final isSelected = _selected[label] ?? false;

    return GestureDetector(
      onTap: () => _onCheckboxChanged(label, !isSelected),
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
            SizedBox(
              width: 32,
              height: 32,
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: isSelected ? Colors.white : Colors.grey.shade600,
                ),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (v) => _onCheckboxChanged(label, v),
                  shape: const CircleBorder(),
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

  void _onContinue() {
    if (!_anySelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one diet preference')),
      );
      return;
    }

    // If you need to pass the selected options forward, build a list here:
    final selectedList = _selected.entries.where((e) => e.value).map((e) => e.key).toList();

    // Example: print or pass to next screen
    // print(selectedList);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Health_ConditionsScreen()),
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
                  "Select your Diet Preference",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                _optionTile('Veg'),
                const SizedBox(height: 12),
                _optionTile('Non-Veg'),
                const SizedBox(height: 12),
                _optionTile('Vegan'),
                const SizedBox(height: 12),
                _optionTile('Eggetarian'),
                const SizedBox(height: 12),
                _optionTile('Keto / Low-Carb'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 115, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: _onContinue,
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
