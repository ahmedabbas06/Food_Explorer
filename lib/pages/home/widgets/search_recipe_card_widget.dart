import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:food_explorer/pages/favourite/favourite_store.dart';
import 'package:food_explorer/pages/meal_details/meal_details_page.dart';

class SearchRecipeCardWidget extends StatelessWidget {
  final MealModel meal;

  const SearchRecipeCardWidget({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsPage(meal: meal),
          ),
        );
      },
      child: Container(
        height: 110.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.10),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Left Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.network(
                meal.image,
                width: 100.w,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100.w,
                    height: double.infinity,
                    color: Colors.black26,
                    child: Icon(
                      Icons.restaurant,
                      color: primaryColor,
                      size: 30.r,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 12.w),

            // Right Recipe Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title & Favorite Heart Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meal.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ValueListenableBuilder<List<MealModel>>(
                        valueListenable: FavouritesStore.instance.meals,
                        builder: (context, _, __) {
                          final isFav = FavouritesStore.instance.isFavourite(meal);
                          return GestureDetector(
                            onTap: () {
                              FavouritesStore.instance.toggle(meal);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : theme.colorScheme.onSurfaceVariant,
                                size: 20.r,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  // Category Subtitle
                  Text(
                    meal.category.isEmpty ? 'Miscellaneous' : meal.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 13.sp,
                    ),
                  ),

                  // Bottom-Right Action Button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 28.r,
                      height: 28.r,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 16.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
