import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottom_nav_item.dart';

class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: BottomNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              isSelected: currentIndex == 0,
              onTap: () => onItemSelected(0),
            ),
          ),
          Expanded(
            child: BottomNavItem(
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite_rounded,
              label: 'Favorites',
              isSelected: currentIndex == 1,
              onTap: () => onItemSelected(1),
            ),
          ),
          Expanded(
            child: BottomNavItem(
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings_rounded,
              label: 'Settings',
              isSelected: currentIndex == 2,
              onTap: () => onItemSelected(2),
            ),
          ),
        ],
      ),
    );
  }
}
