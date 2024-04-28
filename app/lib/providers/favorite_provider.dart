import 'package:app/models/meal_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  bool modifyFavorite(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Meal>>(
    (ref) => FavoriteNotifier());
