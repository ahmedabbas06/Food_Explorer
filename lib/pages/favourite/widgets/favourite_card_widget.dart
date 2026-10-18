
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:food_explorer/pages/meal_details/meal_details_page.dart';
import 'package:food_explorer/pages/favourite/favourite_store.dart';

class FavouriteCardWidget extends StatelessWidget {
  final MealModel meal;

  const FavouriteCardWidget({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageWidth = 88.w;

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
        height: 108.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 5.h,
        ),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: Color(0xFFFF8A3D).withOpacity(0.18),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13.r),
              child: Image.network(
                meal.image,
                width: imageWidth,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: imageWidth,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff2a2a2d),
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Icon(
                      Icons.restaurant_rounded,
                      color: Color(0xffffa04d),
                      size: 28.r,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: Color(0xffffa04d),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          meal.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {
                  FavouritesStore.instance.remove(meal);
                },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.redAccent,
                  size: 21.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
