import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'meal_details_ingredient_card_widget.dart';

class MealDetailsIngredientsGridWidget extends StatelessWidget {
  final List<String> ingredients;
  final List<String> measures;

  MealDetailsIngredientsGridWidget({
    super.key,
    required this.ingredients,
    required this.measures,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    // Filter valid non-empty ingredients
    final List<Map<String, String>> validList = [];
    for (int i = 0; i < ingredients.length; i++) {
      final name = ingredients[i].trim();
      if (name.isNotEmpty) {
        final measure = (i < measures.length) ? measures[i].trim() : '';
        validList.add({
          'name': name,
          'measure': measure,
        });
      }
    }

    if (validList.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.soup_kitchen_rounded,
                      color: primaryColor,
                      size: 20.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '${validList.length} items',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // 2-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: validList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 2.3,
            ),
            itemBuilder: (context, index) {
              final item = validList[index];
              return MealDetailsIngredientCardWidget(
                ingredient: item['name']!,
                measure: item['measure']!,
              );
            },
          ),
        ],
      ),
    );
  }
}
