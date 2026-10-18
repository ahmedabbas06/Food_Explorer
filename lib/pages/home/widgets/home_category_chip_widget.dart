import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryChipWidget extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  const HomeCategoryChipWidget({
    super.key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });

  IconData getCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'all':
        return Icons.grid_view_rounded;
      case 'beef':
        return Icons.restaurant_rounded;
      case 'chicken':
        return Icons.kebab_dining_rounded;
      case 'dessert':
        return Icons.cake_rounded;
      case 'seafood':
        return Icons.set_meal_rounded;
      case 'pasta':
        return Icons.ramen_dining_rounded;
      default:
        return Icons.fastfood_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : theme.dividerColor.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getCategoryIcon(categoryName),
              color: isSelected ? Colors.white : theme.colorScheme.onSurface,
              size: 18.r,
            ),
            SizedBox(width: 8.w),
            Text(
              categoryName,
              style: TextStyle(
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
