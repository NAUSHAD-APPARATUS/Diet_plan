import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF00AF54);
  static const bgColor = Color(0xFFececec);
}

class todayScreen extends StatefulWidget {
  const todayScreen({super.key});

  @override
  State<todayScreen> createState() => _todayScreenState();
}

class _todayScreenState extends State<todayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: const [
                CaloriesCard(
                  progress: 0.00,
                  title: "Calories",
                  icon: Icons.local_fire_department_outlined,
                  centerText: "kcal",
                  color: AppColors.primary,
                ),
                CaloriesCard(
                  progress: 0.00,
                  title: "Fats",
                  icon: Icons.lunch_dining_outlined,
                  centerText: "fats",
                  color: Colors.pinkAccent,
                ),
                CaloriesCard(
                  progress: 0.00,
                  title: "Proteins",
                  icon: Icons.egg_outlined,
                  centerText: "proteins",
                  color: Colors.blueAccent,
                ),
                CaloriesCard(
                  progress: 0.00,
                  title: "Carbs",
                  icon: Icons.rice_bowl_outlined,
                  centerText: "carbs",
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
        ],
      ),
      ),
    );
  }
}

class CaloriesCard extends StatelessWidget {
  final double progress;
  final String title;
  final IconData icon;
  final String centerText;
  final Color color;

  const CaloriesCard({
    super.key,
    required this.progress,
    required this.title,
    required this.icon,
    required this.centerText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const double cardSize = 170;
    const double innerPadding = 15;
    const double circleSize = 75;
    return Container(
      width: cardSize,
      height: cardSize,
      padding: const EdgeInsets.all(innerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),

          const SizedBox(height: 20),


          Center(
            child: SizedBox(
              width: circleSize,
              height: circleSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 14,
                      valueColor:
                      AlwaysStoppedAnimation(color.withOpacity(0.20)),
                    ),
                  ),

                  SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 14,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        centerText,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
