// // main.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:diet_plan_app/firebase_options.dart';
//
// class AppColors {
//   AppColors._();
//   static const primary = Color(0xFF00AF54);
//   static const bgColor = Color(0xFFececec);
//  }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const Second());
// }
//
// class Second extends StatelessWidget {
//   const Second({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Diet Plan',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const SecondScreen(),
//     );
//   }
// }
//
// class SecondScreen extends StatefulWidget {
//   const SecondScreen({super.key});
//
//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   DateTime selectedDate = DateTime.now();
//
//   List<DateTime> getWeekDates(DateTime center) {
//     final monday = center.subtract(Duration(days: center.weekday - 1));
//     return List.generate(7, (i) => DateTime(monday.year, monday.month, monday.day + i));
//   }
//
//   String shortWeekday(DateTime d) {
//     switch (d.weekday) {
//       case DateTime.monday:
//         return 'MON';
//       case DateTime.tuesday:
//         return 'TUE';
//       case DateTime.wednesday:
//         return 'WED';
//       case DateTime.thursday:
//         return 'THU';
//       case DateTime.friday:
//         return 'FRI';
//       case DateTime.saturday:
//         return 'SAT';
//       case DateTime.sunday:
//         return 'SUN';
//       default:
//         return '';
//     }
//   }
//
//   String monthName(int m) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[m - 1];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final weekDates = getWeekDates(selectedDate);
//
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // --- Date header ---
//               DateHeader(
//                 selectedDate: selectedDate,
//                 onTapChevron: () {
//                   setState(() {
//                     selectedDate = selectedDate.add(const Duration(days: 7));
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 12),
//
//               SizedBox(
//                 height: 96,
//                 child: Center(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: weekDates.map((d) {
//                         final isSelected = d.year == selectedDate.year &&
//                             d.month == selectedDate.month &&
//                             d.day == selectedDate.day;
//
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedDate = d;
//                               });
//                             },
//                             child: DatePill(
//                               weekday: shortWeekday(d),
//                               dayNumber: d.day.toString(),
//                               isSelected: isSelected,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               Container(
//                 width: double.infinity,
//                 height: 50,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//               alignment:Alignment.center,
//                 child: const Text("Meal Lists",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//               ),
//
//
//               const SizedBox(height: 20),
//
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       MealCard(
//                         title: "Breakfast",
//                         kcal: "350",
//                         imagePath:"assets/images/breakfast.webp",
//                       ),
//                       SizedBox(width: 16),
//                       MealCard(
//                         title: "Brunch",
//                         kcal: "220",
//                         imagePath:"assets/images/brunch.webp",
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       MealCard(
//                         title: "Lunch",
//                         kcal: "410",
//                         imagePath:"assets/images/lunch.webp",
//                       ),
//                       SizedBox(width: 16),
//                       MealCard(
//                         title: "Snack",
//                         kcal: "120",
//                         imagePath:"assets/images/snacks.webp",
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       MealCard(
//                         title: "Dinner",
//                         kcal: "300",
//                         imagePath:"assets/images/dinner.webp",
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class DateHeader extends StatelessWidget {
//   final DateTime selectedDate;
//   final VoidCallback? onTapChevron;
//
//   const DateHeader({super.key, required this.selectedDate, this.onTapChevron});
//
//   String monthName(int m) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[m - 1];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final text = 'Today, ${selectedDate.day} ${monthName(selectedDate.month)} ${selectedDate.year}';
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//           ),
//         ),
//         GestureDetector(
//           onTap: onTapChevron,
//           child: Container(
//             height: 34,
//             width: 34,
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.keyboard_arrow_right, color: Colors.black54),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DatePill extends StatelessWidget {
//   final String weekday;
//   final String dayNumber;
//   final bool isSelected;
//
//   const DatePill({
//     super.key,
//     required this.weekday,
//     required this.dayNumber,
//     this.isSelected = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 60,
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? AppColors.primary : Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: isSelected ? null : Border.all(color: AppColors.primary.withOpacity(0.25), width: 2),
//         boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.18), blurRadius: 6, offset: const Offset(0,3))] : [],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             weekday,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: isSelected ? Colors.white : AppColors.primary,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.white : Colors.transparent,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               dayNumber,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: isSelected ? AppColors.primary : Colors.black87,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class MealCard extends StatelessWidget {
//   final String title;
//   final String kcal;
//   final String imagePath;
//   final VoidCallback? onTap;
//
//   const MealCard({
//     super.key,
//     required this.title,
//     required this.kcal,
//     required this.imagePath,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 150,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // image + arrow icon
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     imagePath,
//                     height: 80,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, _) {
//                       return Container(
//                         height: 80,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(Icons.fastfood, size: 34, color: Colors.grey.shade600),
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   right: 6,
//                   top: 6,
//                   child: Container(
//                     height: 28,
//                     width: 28,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
//                       ],
//                     ),
//                     child: const Icon(Icons.arrow_outward, size: 16),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 10),
//
//             Text(
//               title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//
//             const SizedBox(height: 6),
//
//             Row(
//               children: [
//                 const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
//                 const SizedBox(width: 6),
//                 Text(
//                   "$kcal kcal",
//                   style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
