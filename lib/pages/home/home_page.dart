import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/meal_provider.dart';
import 'widgets/home_categories_section_widget.dart';
import 'widgets/home_featured_recipe_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/home_popular_recipes_section_widget.dart';
import 'widgets/home_search_results_widget.dart';
import 'widgets/home_search_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  final List<String> categories = [
    'All',
    'Beef',
    'Chicken',
    'Dessert',
    'Seafood',
    'Pasta',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) {
    setState(() {
      isSearching = query.trim().isNotEmpty;
    });
    context.read<MealProvider>().searchMeals(query);
  }

  void clearSearch() {
    searchController.clear();
    setState(() {
      isSearching = false;
    });
    context.read<MealProvider>().getMeals();
  }

  void onCategorySelected(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
      });

      if (category == 'All') {
        context.read<MealProvider>().getMeals();
      } else {
        context.read<MealProvider>().getMealsByCategory(category);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            16.w,
            16.h,
            16.w,
            100.h,
          ),
          children: [
            // Header Bar Widget
            HomeHeaderWidget(
              onNotificationTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No new notifications'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            SizedBox(height: 18.h),

            // Search Bar Widget
            HomeSearchWidget(
              searchController: searchController,
              isSearching: isSearching,
              onSearch: performSearch,
              onClear: clearSearch,
            ),

            SizedBox(height: 22.h),

            // Conditionally Render Search Results OR Home Main Sections
            if (isSearching)
              HomeSearchResultsWidget(
                searchText: searchController.text,
                onClearSearch: clearSearch,
              )
            else ...[
              // Featured Recipe Banner Widget
              HomeFeaturedRecipeWidget(),

              SizedBox(height: 22.h),

              // Categories Horizontal List Widget
              HomeCategoriesSectionWidget(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: onCategorySelected,
              ),

              SizedBox(height: 22.h),

              // Popular Recipes 2-Column Grid Widget
              HomePopularRecipesSectionWidget(
                selectedCategory: selectedCategory,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
