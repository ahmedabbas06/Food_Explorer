import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: Color(0xFFFF8A3D),
              size: 20.r,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'Akelaty - أكلاتي',
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),

          SizedBox(height: 3.h),

          Text(
            'V1.0',
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
