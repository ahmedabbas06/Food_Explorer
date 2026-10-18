import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeHeader extends StatelessWidget {
  ThemeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.colorScheme.onSurface,
              size: 18.r,
            ),
          ),
        ),

        SizedBox(width: 14.w),

        Text(
          'Theme',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
