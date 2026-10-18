import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetailsSectionTitleWidget extends StatelessWidget {
  final String title;

  const MealDetailsSectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16.w),
        Container(
          width: 4.w,
          height: 26.h,
          decoration: BoxDecoration(
            color: Color(0xffff6e00),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
