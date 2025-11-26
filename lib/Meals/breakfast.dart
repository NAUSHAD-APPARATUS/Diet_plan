 //main.dart
 import 'package:diet_plan_app/Meals/meals1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diet_plan_app/firebase_options.dart';

class AppColors { AppColors._();
  static const primary = Color(0xFF00AF54);
  static const bgColor = Color(0xFFececec);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const breakfast());
}
class breakfast extends StatelessWidget {
  const breakfast({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Diet Plan',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const breakfastScreen(),
    );
  }
}
class breakfastScreen extends StatefulWidget {
  const breakfastScreen({super.key});
  @override State<breakfastScreen> createState() => _breakfastScreenState();
}
class _breakfastScreenState extends State<breakfastScreen> {
  int selectedTab = 0;
  final List<String> mealTabs = ["All", "My Meals"];

  // canonical list of available meals (static)
  final List<Map<String, String>> breakfastItems = [
    {
      "title": "Oatmeal Bowl",
      "subtitle": "Healthy whole oats",
      "kcal": "250",
      "image": "assets/images/oatmeal.webp",
    },
    {
      "title": "Peanut Butter Toast",
      "subtitle": "High protein toast",
      "kcal": "210",
      "image": "assets/images/peanut_toast.webp",
    },
    {
      "title": "Scrambled Eggs",
      "subtitle": "2 eggs cooked",
      "kcal": "180",
      "image": "assets/images/scrambled_eggs.webp",
    },
    {
      "title": "Greek Yogurt + Berries",
      "subtitle": "Low-fat yogurt",
      "kcal": "190",
      "image": "assets/images/yogurt_berries.webp",
    },
    {
      "title": "Avocado Toast",
      "subtitle": "Whole-grain toast + mashed avocado",
      "kcal": "240",
      "image": "assets/images/avacado_toast.webp",
    },
    {
      "title": "Banana Smoothie",
      "subtitle": "Banana + oats + milk",
      "kcal": "160",
      "image": "assets/images/banana_smoothie.webp",
    },
    {
      "title": "Veggie Omelette",
      "subtitle": "Egg whites + veggies",
      "kcal": "220",
      "image": "assets/images/veggie_omelette.webp",
    },
    {
      "title": "Protein Pancakes",
      "subtitle": "Oat + egg + protein mix",
      "kcal": "280",
      "image": "assets/images/protein_pancakes.webp",
    },
    {
      "title": "Fruit Salad Bowl",
      "subtitle": "Mixed fresh fruits",
      "kcal": "140",
      "image": "assets/images/fruit_salad_bowl.webp",
    },
    {
      "title": "Whole-Grain Cereal",
      "subtitle": "High-fiber cereal + milk",
      "kcal": "190",
      "image": "assets/images/whole_grain_cereal.webp",
    },
    {
      "title": "Cottage Cheese Bowl",
      "subtitle": "Cottage cheese + honey + nuts",
      "kcal": "220",
      "image": "assets/images/cottage_cheese_bowl.webp",
    },
  ];


  final Map<String, int> quantities = {};


  List<Map<String, String>> get myMeals =>
      breakfastItems.where((item) => (quantities[item['title']!] ?? 0) > 0).toList();

  void incrementMeal(String title) {
    setState(() {
      quantities[title] = (quantities[title] ?? 0) + 1;
    });
  }

  void decrementMeal(String title) {
    setState(() {
      final current = (quantities[title] ?? 0);
      if (current <= 1) {
        quantities.remove(title);
      } else {
        quantities[title] = current - 1;
      }
    });
  }

  int qtyOf(String title) => quantities[title] ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Breakfast",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Opacity(opacity: 0, child: Icon(Icons.arrow_back)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(mealTabs.length, (index) {
                final isSelected = selectedTab == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected ? Border.all(color: AppColors.primary, width: 1.5) : null,
                    ),
                    child: Text(
                      mealTabs[index],
                      style: TextStyle(color: isSelected ? AppColors.primary : Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: selectedTab == 0 ? _buildMealList(breakfastItems, isMyMealsList: false) : _buildMealList(myMeals, isMyMealsList: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealList(List<Map<String, String>> items, {required bool isMyMealsList}) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          isMyMealsList ? 'No meals added yet' : 'No items available',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
        bottom: MediaQuery.of(context).padding.bottom + 35,
      ),

      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        final title = item['title']!;
        final qty = qtyOf(title);

        return BreakfastCardLarge(
          title: title,
          subtitle: item['subtitle'] ?? '',
          kcal: item['kcal'] ?? '',
          imagePath: item['image'] ?? '',
          qty: qty,
          isMyMealsList: isMyMealsList,
          onAdd: () {
            incrementMeal(title);
          },
          onRemove: () {
            decrementMeal(title);
          },
        );
      },
    );
  }
}

 class BreakfastCardLarge extends StatelessWidget {
   final String title;
   final String subtitle;
   final String kcal;
   final String imagePath;
   final int qty;
   final bool isMyMealsList;
   final VoidCallback? onAdd;
   final VoidCallback? onRemove;

   const BreakfastCardLarge({
     super.key,
     required this.title,
     required this.subtitle,
     required this.kcal,
     required this.imagePath,
     this.qty = 0,
     this.isMyMealsList = false,
     this.onAdd,
     this.onRemove,
   });

   @override
   Widget build(BuildContext context) {
     const double cardHeight = 145.0;
     const double imageWidth = 110.0;

     return Container(
       width: double.infinity,
       height: cardHeight,
       padding: const EdgeInsets.all(12),
       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
       child: Row(
         children: [
           SizedBox(
             width: imageWidth,
             height: double.infinity,
             child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: imagePath.isNotEmpty
                   ? Image.asset(
                 imagePath,
                 width: imageWidth,
                 height: cardHeight - 8,
                 fit: BoxFit.cover,
                 errorBuilder: (_, __, ___) => Container(
                   color: Colors.grey.shade200,
                   child: const Icon(Icons.food_bank, size: 36, color: Colors.grey),
                 ),
               )
                   : Container(
                 color: Colors.grey.shade200,
                 child: const Icon(Icons.food_bank, size: 36, color: Colors.grey),
               ),
             ),
           ),

           const SizedBox(width: 12),

           Expanded(
             flex: 2,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // title
                 Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 6),

                 Row(
                   children: [
                     Expanded(
                       child: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
                     ),
                     const SizedBox(width: 8),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
                           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 6, offset: Offset(0,2))]),
                       child: Text('$qty', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                     ),
                   ],
                 ),

                 const SizedBox(height: 10),

                 Row(
                   children: [
                     Text('$kcal kcal', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                     const Spacer(),
                     ElevatedButton(
                       onPressed: isMyMealsList ? onRemove : onAdd,
                       style: ElevatedButton.styleFrom(
                         backgroundColor: isMyMealsList ? Colors.red : AppColors.primary,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         elevation: 0,
                         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                       ),
                       child: Text(isMyMealsList ? "Remove Meal" : "Add Meal", style: const TextStyle(color: Colors.white)),
                     ),
                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     );
   }
 }