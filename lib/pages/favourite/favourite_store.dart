import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared favourites state synchronized with Cloud Firestore and SharedPreferences.
class FavouritesStore {
  FavouritesStore._internal() {
    loadFromPrefs();
    setupAuthListener();
  }

  static final FavouritesStore instance = FavouritesStore._internal();

  static String storageKey = 'saved_favourites_meals';

  final ValueNotifier<List<MealModel>> meals = ValueNotifier<List<MealModel>>(
    [],
  );

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<User?>? authSub;

  void setupAuthListener() {
    authSub = firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        syncFromFirestore(user.uid);
      }
    });
  }

  bool isFavourite(MealModel meal) => meals.value.any((m) => m.id == meal.id);

  void toggle(MealModel meal) {
    if (isFavourite(meal)) {
      remove(meal);
    } else {
      meals.value = [...meals.value, meal];
      saveToPrefs();
      saveToFirestore(meal, isAdd: true);
    }
  }

  void remove(MealModel meal) {
    meals.value = meals.value.where((m) => m.id != meal.id).toList();
    saveToPrefs();
    saveToFirestore(meal, isAdd: false);
  }

  Future<void> syncFromFirestore(String uid) async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .get();

      if (snapshot.docs.isNotEmpty) {
        final List<MealModel> loaded = [];
        for (final doc in snapshot.docs) {
          final data = doc.data();
          loaded.add(MealModel.fromJson(data));
        }
        meals.value = loaded;
        saveToPrefs();
      } else if (meals.value.isNotEmpty) {
        // Upload existing local favorites to Firestore for new user
        for (final meal in meals.value) {
          await firestore
              .collection('users')
              .doc(uid)
              .collection('favorites')
              .doc(meal.id)
              .set(mealToMap(meal));
        }
      }
    } catch (e) {
      debugPrint('Firestore favorites sync error: $e');
    }
  }

  Future<void> saveToFirestore(MealModel meal, {required bool isAdd}) async {
    final user = firebaseAuth.currentUser;
    if (user == null) return;

    try {
      final docRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(meal.id);

      if (isAdd) {
        await docRef.set(mealToMap(meal));
      } else {
        await docRef.delete();
      }
    } catch (e) {
      debugPrint('Firestore favorites write error: $e');
    }
  }

  Future<void> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(storageKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> decodedList = jsonDecode(jsonString);
        final List<MealModel> loadedMeals = [];
        for (final item in decodedList) {
          if (item is Map) {
            loadedMeals.add(
              MealModel.fromJson(Map<String, dynamic>.from(item)),
            );
          }
        }
        meals.value = loadedMeals;
      }
    } catch (_) {
      // Safely ignore corrupted data
    }
  }

  Future<void> saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> mapped = meals.value
          .map(mealToMap)
          .toList();
      await prefs.setString(storageKey, jsonEncode(mapped));
    } catch (_) {
      // Safely ignore storage write failures
    }
  }

  Map<String, dynamic> mealToMap(MealModel meal) {
    final map = <String, dynamic>{
      'idMeal': meal.id,
      'strMeal': meal.name,
      'strMealThumb': meal.image,
      'strCategory': meal.category,
      'strArea': meal.area,
      'strInstructions': meal.instructions,
      'strTags': meal.tags.join(','),
      'strYoutube': meal.youtube,
      'strSource': meal.source,
    };
    for (int i = 0; i < meal.ingredients.length && i < 20; i++) {
      map['strIngredient${i + 1}'] = meal.ingredients[i];
    }
    for (int i = 0; i < meal.measures.length && i < 20; i++) {
      map['strMeasure${i + 1}'] = meal.measures[i];
    }
    return map;
  }
}
