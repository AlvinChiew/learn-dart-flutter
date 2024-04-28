import 'package:app/components/meal_item.dart';
import 'package:app/models/meal_model.dart';
import 'package:app/screens/meal_screen.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.meals, this.title, {super.key});

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    void overlayMealScreen(BuildContext context, Meal meal) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => MealScreen(meal)));
    }

    Widget content = meals.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Opps... Nothing here yet!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
                Text(
                  'Try selecting a different category :)',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(meals[index], () {
                  overlayMealScreen(context, meals[index]);
                }));

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
