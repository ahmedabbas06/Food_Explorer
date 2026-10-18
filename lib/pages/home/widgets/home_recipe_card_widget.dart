import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:food_explorer/pages/favourite/favourite_store.dart';
import 'package:food_explorer/pages/meal_details/meal_details_page.dart';

class HomeRecipeCardWidget extends StatelessWidget {
  final MealModel meal;
  final String fallbackCategory;

  const HomeRecipeCardWidget({
    super.key,
    required this.meal,
    required this.fallbackCategory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailsPage(meal: meal),
                      ),
                    );
                  },
                  child: Image.network(
                    meal.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black26,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 36.r,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Favorite Button
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: ValueListenableBuilder<List<MealModel>>(
                    valueListenable: FavouritesStore.instance.meals,
                    builder: (context, _, __) {
                      final isFav = FavouritesStore.instance.isFavourite(meal);
                      return GestureDetector(
                        onTap: () {
                          FavouritesStore.instance.toggle(meal);
                        },
                        child: Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.white,
                            size: 18.r,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Details Button (Orange Arrow)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetailsPage(meal: meal),
                        ),
                      );
                    },
                    child: Container(
                      width: 30.r,
                      height: 30.r,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Meal Information
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  meal.category.isEmpty ? fallbackCategory : meal.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
