// main.dart
import 'package:diet_plan_app/Home/today.dart';
import 'package:diet_plan_app/Meals/breakfast.dart';
import 'package:diet_plan_app/Meals/brunch.dart';
import 'package:diet_plan_app/Meals/dinner.dart';
import 'package:diet_plan_app/Meals/lunch.dart';
import 'package:diet_plan_app/Meals/snacks.dart';
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
  runApp(const Second());
}

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SecondScreen(),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  DateTime selectedDate = DateTime.now();
  final DateTime todayDate = DateTime.now();


  List<DateTime> getWeekDates(DateTime center) {
    final monday = center.subtract(Duration(days: center.weekday - 1));
    return List.generate(7, (i) => DateTime(monday.year, monday.month, monday.day + i));
  }

  String shortWeekday(DateTime d) {
    switch (d.weekday) {
      case DateTime.monday:
        return 'MON';
      case DateTime.tuesday:
        return 'TUE';
      case DateTime.wednesday:
        return 'WED';
      case DateTime.thursday:
        return 'THU';
      case DateTime.friday:
        return 'FRI';
      case DateTime.saturday:
        return 'SAT';
      case DateTime.sunday:
        return 'SUN';
      default:
        return '';
    }
  }

  String monthName(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = getWeekDates(selectedDate);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              DateHeader(
                selectedDate: todayDate,
                //selectedate : selectedDate,
                onTapChevron: null,
                // onTapChevron: () {
                //   setState(() {
                //     selectedDate = selectedDate.add(const Duration(days: 7));
                //   });
                // },
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 96,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: weekDates.map((d) {
                        final isSelected = d.year == selectedDate.year &&
                            d.month == selectedDate.month &&
                            d.day == selectedDate.day;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = d;
                              });
                            },
                            child: DatePill(
                              weekday: shortWeekday(d),
                              dayNumber: d.day.toString(),
                              isSelected: isSelected,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text("Meal Lists",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 35),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return MealCardLarge(
                          title: "Breakfast",
                          subtitle: "Recommended 830-1170Cal",
                          kcal: "350",
                          imagePath: "assets/images/breakfast.webp",
                          onAdd: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>breakfastScreen()));
                          },
                        );
                      case 1:
                        return MealCardLarge(
                          title: "Brunch",
                          subtitle: "Recommended 200-350Cal",
                          kcal: "220",
                          imagePath: "assets/images/brunch.webp",
                          onAdd: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>brunchScreen()));
                          },
                        );
                      case 2:
                        return MealCardLarge(
                          title: "Lunch",
                          subtitle: "Recommended 400-600Cal",
                          kcal: "410",
                          imagePath: "assets/images/lunch.webp",
                          onAdd: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>lunchScreen()));
                          },
                        );
                      case 3:
                        return MealCardLarge(
                          title: "Snacks",
                          subtitle: "Recommended 150-250Cal",
                          kcal: "120",
                          imagePath: "assets/images/snacks.webp",
                          onAdd: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>snacksScreen()));
                          },
                        );
                      case 4:
                        return MealCardLarge(
                          title: "Dinner",
                          subtitle: "Recommended 300-500Cal",
                          kcal: "300",
                          imagePath: "assets/images/dinner.webp",
                          onAdd: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>dinnerScreen()));
                          },
                        );
                      default:
                      // final spacer so the last item isn't clipped by gesture nav
                        return const SizedBox(height: 30);
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class DateHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onTapChevron;

  const DateHeader({super.key, required this.selectedDate, this.onTapChevron});

  String monthName(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    final text = 'Today, ${selectedDate.day} ${monthName(selectedDate.month)} ${selectedDate.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        GestureDetector(
          onTap: onTapChevron,
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard_arrow_right, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

class DatePill extends StatelessWidget {
  final String weekday;
  final String dayNumber;
  final bool isSelected;

  const DatePill({
    super.key,
    required this.weekday,
    required this.dayNumber,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? null : Border.all(color: AppColors.primary.withOpacity(0.25), width: 2),
        boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.18), blurRadius: 6, offset: const Offset(0,3))] : [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weekday,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              dayNumber,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}


class MealCardLarge extends StatelessWidget {
  final String title;
  final String subtitle;
  final String kcal;
  final String imagePath;
  final VoidCallback? onAdd;

  const MealCardLarge({
    super.key,
    required this.title,
    required this.subtitle,
    required this.kcal,
    required this.imagePath,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 126.0;
    final double circleSize = 96.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0,3))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const Spacer(),
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  elevation: 0,
                ),
                child: const Text("+ Add", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),


        Positioned(
          right: 11,
          top: (cardHeight - circleSize) / 2,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0,3))],
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
