import 'package:flutter/foundation.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';

/// Shared favourites state used by MealDetailsPage and FavouritePage.
class FavouritesStore {
  FavouritesStore._();
  static final FavouritesStore instance = FavouritesStore._();

  final ValueNotifier<List<MealModel>> meals = ValueNotifier<List<MealModel>>([]);

  bool isFavourite(MealModel meal) => meals.value.any((m) => m.id == meal.id);

  void toggle(MealModel meal) {
    if (isFavourite(meal)) {
      remove(meal);
    } else {
      meals.value = [...meals.value, meal];
    }
  }

  void remove(MealModel meal) {
    meals.value = meals.value.where((m) => m.id != meal.id).toList();
  }
}