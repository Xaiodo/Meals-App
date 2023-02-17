import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-dateil';
  final Function toggleFavorites;
  final Function isMealFavorite;
  const MealDetailScreen(
      {Key? key, required this.toggleFavorites, required this.isMealFavorite})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 195, 172),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var id = 0;
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients:'),
          buildContainer(
            Column(
              children: selectedMeal.ingredients
                  .map(
                    (e) => Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          buildSectionTitle(context, 'Steps:'),
          buildContainer(
            Column(
              children: selectedMeal.steps
                  .map(
                    (e) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              '#${++id}',
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                          ),
                          title: Text(e),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorites(mealId) as VoidCallback,
        child: Icon(isMealFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
