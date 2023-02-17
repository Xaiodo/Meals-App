import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: displayedMeals == null
          ? const Center(
              child: Text(
                'Opps, there are no available meals.',
                style: TextStyle(color: Colors.amber),
              ),
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return MealItem(
                  id: displayedMeals![index].id,
                  title: displayedMeals![index].title,
                  imageUrl: displayedMeals![index].imageUrl,
                  duration: displayedMeals![index].duration,
                  complexity: displayedMeals![index].complexity,
                  affordability: displayedMeals![index].affordability,
                );
              }),
              itemCount: displayedMeals!.length,
            ),
    );
  }
}
