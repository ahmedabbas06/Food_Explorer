import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/meal_model/meal_model.dart';
import '../../../providers/meal_provider.dart';
import '../../favourite/favourite_store.dart';
import '../../meal_details/meal_details_page.dart';

class HomeFeaturedRecipeWidget extends StatelessWidget {
  const HomeFeaturedRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Recipe',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 12.h),

        Consumer<MealProvider>(
          builder: (context, mealProvider, child) {
            if (mealProvider.isLoading && mealProvider.meals.isEmpty) {
              return Container(
                height: 190.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }

            if (mealProvider.meals.isEmpty) {
              return Container(
                height: 190.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    'No featured recipe',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              );
            }

            final meal = mealProvider.meals.first;

            return Container(
              height: 190.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20.r),
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
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 40.r,
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
                          AppColors.black.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),

                  // Favorite Button Top Right
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: ValueListenableBuilder<List<MealModel>>(
                      valueListenable: FavouritesStore.instance.meals,
                      builder: (context, favoriteMeals, child) {
                        final isFav = FavouritesStore.instance.isFavourite(
                          meal,
                        );
                        return GestureDetector(
                          onTap: () {
                            FavouritesStore.instance.toggle(meal);
                          },
                          child: Container(
                            width: 34.r,
                            height: 34.r,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.white,
                              size: 20.r,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
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
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                meal.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MealDetailsPage(meal: meal),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View Recipe",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 16.r,
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
      ],
    );
  }
}
