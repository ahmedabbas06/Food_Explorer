import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/meal_provider.dart';
import '../meal_details/meal_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String selectedCategory = 'All';
  final TextEditingController searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Search for recipes...',
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.neutral,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Search Button
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.read<MealProvider>().searchMeals(
                        searchController.text,
                      );
                    },
                    icon: Icon(Icons.search, color: AppColors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ==================== Featured Recipe ====================
            Text(
              'Featured Recipe',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Consumer<MealProvider>(
              builder: (context, mealProvider, child) {
                // Loading
                if (mealProvider.isLoading && mealProvider.meals.isEmpty) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }

                // No meals
                if (mealProvider.meals.isEmpty) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'No featured recipe',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ),
                  );
                }

                final meal = mealProvider.meals.first;

                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.neutral,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Image.network(
                        meal.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.grey,
                              size: 40,
                            ),
                          );
                        },
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),

                      // ==================== Favorite ====================
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.65),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Favorite
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.category.isEmpty
                                        ? 'Featured Recipe'
                                        : meal.category,
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    meal.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Details Button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "View Recipe",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MealDetailsPage(meal: meal),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // ==================== Categories ====================
            Text(
              'Categories',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // All
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'All';
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'All'
                            ? AppColors.primary
                            : AppColors.neutral,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: selectedCategory == 'All'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                  // Beef
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Beef';
                      });
                      context.read<MealProvider>().getMealsByCategory('Beef');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Beef'
                            ? AppColors.primary
                            : AppColors.neutral,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Beef',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: selectedCategory == 'Beef'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                  // Chicken
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Chicken';
                      });

                      context.read<MealProvider>().getMealsByCategory(
                        'Chicken',
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Chicken'
                            ? AppColors.primary
                            : AppColors.neutral,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Chicken',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: selectedCategory == 'Chicken'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                  // Dessert
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Dessert';
                      });

                      context.read<MealProvider>().getMealsByCategory(
                        'Dessert',
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Dessert'
                            ? AppColors.primary
                            : AppColors.neutral,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Dessert',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: selectedCategory == 'Dessert'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                  // Pasta
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Pasta';
                      });
                      context.read<MealProvider>().getMealsByCategory('Pasta');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Pasta'
                            ? AppColors.primary
                            : AppColors.neutral,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Pasta',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: selectedCategory == 'Pasta'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================== Popular Recipes ====================
            Text(
              'Popular Recipes',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Consumer<MealProvider>(
              builder: (context, mealProvider, child) {
                // Loading
                if (mealProvider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Error
                if (mealProvider.errorMessage != null) {
                  return Center(
                    child: Text(
                      mealProvider.errorMessage!,
                      style: TextStyle(color: AppColors.white),
                    ),
                  );
                }

                // No meals
                if (mealProvider.meals.isEmpty) {
                  return Center(
                    child: Text(
                      'No meals found',
                      style: TextStyle(color: AppColors.grey, fontSize: 16),
                    ),
                  );
                }

                // Meals
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mealProvider.meals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final meal = mealProvider.meals[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Image.network(
                                  meal.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: AppColors.grey,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),

                                // Favorite Button
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.black.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // Favorite
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                // Details Button
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MealDetailsPage(meal: meal),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ==================== Meal Information ====================
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  meal.category.isEmpty
                                      ? selectedCategory
                                      : meal.category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
