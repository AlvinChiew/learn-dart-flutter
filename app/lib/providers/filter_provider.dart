import 'package:app/models/meal_model.dart';
import 'package:app/providers/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  isGlutenFree,
  isLactoseFree,
  isVegetarian,
  isVegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.isGlutenFree: false,
          Filter.isLactoseFree: false,
          Filter.isVegetarian: false,
          Filter.isVegan: false,
        });

  void modifyFilters(Map<Filter, bool> filters) => state = filters;

  void modifyFilter(Filter filter, bool status) {
    state = {...state, filter: status};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealProvider);
  final filters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (filters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filter.isVegan]! && !meal.isVegan) {
      return false;
    }
    if (filters[Filter.isVegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
