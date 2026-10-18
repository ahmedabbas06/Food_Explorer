import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/meal_provider.dart';
import 'home_recipe_card_widget.dart';

class HomePopularRecipesSectionWidget extends StatelessWidget {
  final String selectedCategory;

  const HomePopularRecipesSectionWidget({super.key, required this.selectedCategory});

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
              'Popular Recipes',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        Consumer<MealProvider>(
          builder: (context, mealProvider, child) {
            if (mealProvider.isLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(30.r),
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }

            if (mealProvider.errorMessage != null) {
              return Center(
                child: Text(
                  mealProvider.errorMessage!,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15.sp,
                  ),
                ),
              );
            }

            if (mealProvider.meals.isEmpty) {
              return Center(
                child: Text(
                  'No meals found',
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 15.sp,
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mealProvider.meals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final meal = mealProvider.meals[index];

                return HomeRecipeCardWidget(
                  meal: meal,
                  fallbackCategory: selectedCategory,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
