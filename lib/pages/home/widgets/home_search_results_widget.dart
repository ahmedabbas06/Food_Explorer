import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/meal_provider.dart';
import 'search_recipe_card_widget.dart';

class HomeSearchResultsWidget extends StatelessWidget {
  final String searchText;
  final VoidCallback onClearSearch;

  const HomeSearchResultsWidget({
    super.key,
    required this.searchText,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onClearSearch,
              child: Text(
                'Clear',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        Consumer<MealProvider>(
          builder: (context, mealProvider, child) {
            if (mealProvider.isLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(40.r),
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }

            if (mealProvider.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(30.r),
                  child: Text(
                    mealProvider.errorMessage!,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              );
            }

            if (mealProvider.meals.isEmpty) {
              return Container(
                padding: EdgeInsets.all(30.r),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 60.r,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'No recipes found for "$searchText"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Try searching for "pizza", "chicken", "beef", or "pasta"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mealProvider.meals.length,
              itemBuilder: (context, index) {
                final meal = mealProvider.meals[index];
                return SearchRecipeCardWidget(meal: meal);
              },
            );
          },
        ),
      ],
    );
  }
}
