import 'package:app/components/category_grid_item.dart';
import 'package:app/data/dummy_data.dart';
import 'package:app/models/meal_category_model.dart';
import 'package:app/models/meal_model.dart';
import 'package:app/screens/meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(this.onToggleFavorite, this.filteredMeal, {super.key});
  final Function(Meal meal) onToggleFavorite;
  final List<Meal> filteredMeal;

  void _overlayMealsScreen(BuildContext context, MealCategory category) {
    final meals = filteredMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(meals, category.title, onToggleFavorite)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: categoryData
          .map((c) => CategoryGridItem(c, () {
                _overlayMealsScreen(context, c);
              }))
          .toList(),
    );
  }
}
