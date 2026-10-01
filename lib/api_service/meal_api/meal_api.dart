import 'package:dio/dio.dart';

import '../../models/meal_model/meal_model.dart';

class MealApi {
  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'),
  );

  // ==================== Get All Meals ====================

  Future<List<MealModel>> getMeals() async {
    try {
      final response = await dio.get('search.php?s=');

      final data = response.data;

      if (data['meals'] == null) {
        return [];
      }

      return (data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();
    } catch (e) {
      throw Exception('Failed to load meals');
    }
  }

  // ==================== Get Meals By Category ====================

  Future<List<MealModel>> getMealsByCategory(String category) async {
    try {
      final response = await dio.get(
        'filter.php',
        queryParameters: {'c': category},
      );

      final data = response.data;

      if (data['meals'] == null) {
        return [];
      }

      return (data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();
    } catch (e) {
      throw Exception('Failed to load meals by category');
    }
  }

  // ==================== Search Meals ====================

  Future<List<MealModel>> searchMeals(String query) async {
    try {
      final response = await dio.get(
        'search.php',
        queryParameters: {'s': query},
      );

      final data = response.data;

      if (data['meals'] == null) {
        return [];
      }

      return (data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();
    } catch (e) {
      throw Exception('Failed to search meals');
    }
  }

  // ==================== Get Meal Details ====================

  Future<MealModel?> getMealDetails(String id) async {
    try {
      final response = await dio.get(
        'lookup.php',
        queryParameters: {'i': id},
      );

      final data = response.data;

      if (data['meals'] == null || (data['meals'] as List).isEmpty) {
        return null;
      }

      return MealModel.fromJson(data['meals'][0]);
    } catch (e) {
      throw Exception('Failed to load meal details');
    }
  }
}