import 'package:flutter/material.dart';

import '../api_service/meal_api/meal_api.dart';
import '../models/meal_model/meal_model.dart';

class MealProvider extends ChangeNotifier {
  final MealApi mealApi = MealApi();

  List<MealModel> meals = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> getMeals() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      meals = await mealApi.getMeals();
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getMealsByCategory(String category) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      meals = await mealApi.getMealsByCategory(category);
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchMeals(String query) async {
    if (query.trim().isEmpty) {
      await getMeals();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      meals = await mealApi.searchMeals(query);
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }
}
