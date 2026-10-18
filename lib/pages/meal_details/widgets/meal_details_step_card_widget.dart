import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetailsStepCardWidget extends StatelessWidget {
  final int index;
  final String step;
  final bool isLast;

  const MealDetailsStepCardWidget({
    super.key,
    required this.index,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Color(0xffff6e00),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Color(0xff4b2d1b),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
            ],
          ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 14.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step ${index + 1}",
                  style: TextStyle(
                    color: Color(0xffff6e00),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  step,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 15.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }
}
