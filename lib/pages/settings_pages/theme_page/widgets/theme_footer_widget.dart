import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeFooter extends StatelessWidget {
  const ThemeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: Color(0xFFFF8A3D),
              size: 22.r,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'Akelaty - أكلاتي',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 3.h),
          Text(
            'V1.0',
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
