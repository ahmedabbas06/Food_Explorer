import 'dart:math';
import 'package:dio/dio.dart';

import '../../models/meal_model/meal_model.dart';

class MealApi {
  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'),
  );

  List<MealModel>? cachedAllMeals;

  // ==================== Get All Meals ====================

  Future<List<MealModel>> getMeals() async {
    try {
      final response = await dio.get('search.php?s=');

      final data = response.data;

      if (data['meals'] == null) {
        return [];
      }

      final mealsList = (data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();

      cachedAllMeals = mealsList;
      return mealsList;
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

  // ==================== Typo-Tolerant Search Meals ====================

  Future<List<MealModel>> searchMeals(String query) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return getMeals();
    }

    try {
      // 1. Primary search request to API
      final response = await dio.get(
        'search.php',
        queryParameters: {'s': cleanQuery},
      );

      final data = response.data;

      if (data['meals'] != null && (data['meals'] as List).isNotEmpty) {
        return (data['meals'] as List)
            .map((meal) => MealModel.fromJson(meal))
            .toList();
      }

      // 2. Typo-tolerant fuzzy matching fallback for queries like 'piza', 'pizaa', 'chiken', 'burgar'
      List<MealModel> candidateMeals = cachedAllMeals ?? [];
      if (candidateMeals.isEmpty) {
        candidateMeals = await getMeals();
      }

      final List<Map<String, dynamic>> scoredMeals = [];

      for (final meal in candidateMeals) {
        final mealName = meal.name.toLowerCase();
        final categoryName = meal.category.toLowerCase();

        double bestScore = 0.0;

        // Compare query with full meal name
        final nameScore = computeStringSimilarity(cleanQuery, mealName);
        if (nameScore > bestScore) bestScore = nameScore;

        // Compare query with individual words in meal name
        final nameWords = mealName.split(RegExp(r'\s+'));
        for (final word in nameWords) {
          if (word.length >= 3) {
            final wordScore = computeStringSimilarity(cleanQuery, word);
            if (wordScore > bestScore) bestScore = wordScore;
          }
        }

        // Compare query with category name
        final catScore = computeStringSimilarity(cleanQuery, categoryName);
        if (catScore * 0.8 > bestScore) bestScore = catScore * 0.8;

        // Bonus score for prefix or substring match
        if (mealName.contains(cleanQuery) || cleanQuery.contains(mealName)) {
          bestScore = max(bestScore, 0.85);
        }

        if (bestScore >= 0.35 || calculateLevenshteinDistance(cleanQuery, mealName) <= 3) {
          scoredMeals.add({
            'meal': meal,
            'score': bestScore,
          });
        }
      }

      // Sort candidate meals descending by match score
      scoredMeals.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

      return scoredMeals.map((item) => item['meal'] as MealModel).toList();
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

  // ==================== Fuzzy Search Helper Functions ====================

  double computeStringSimilarity(String s1, String s2) {
    if (s1 == s2) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final distance = calculateLevenshteinDistance(s1, s2);
    final maxLen = max(s1.length, s2.length);
    return 1.0 - (distance / maxLen);
  }

  int calculateLevenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> v0 = List<int>.generate(s2.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (int j = 0; j < s2.length; j++) {
        final cost = (s1.codeUnitAt(i) == s2.codeUnitAt(j)) ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      for (int j = 0; j < v0.length; j++) {
        v0[j] = v1[j];
      }
    }

    return v1[s2.length];
  }
}
