import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetailsIngredientCardWidget extends StatelessWidget {
  final String ingredient;
  final String measure;

  MealDetailsIngredientCardWidget({
    super.key,
    required this.ingredient,
    required this.measure,
  });

  String getIngredientImage(String ingredientName) {
    final name = ingredientName.trim().replaceAll(' ', '%20');
    return 'https://www.themealdb.com/images/ingredients/$name-Small.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orangeColor = Color(0xFFFF8A3D);

    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.10),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                getIngredientImage(ingredient),
                width: 44.w,
                height: 44.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.restaurant,
                    color: orangeColor,
                    size: 22.r,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (measure.trim().isNotEmpty) ...[
                  SizedBox(height: 3.h),
                  Text(
                    measure,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: orangeColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
