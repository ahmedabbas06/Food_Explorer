import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'meal_details_step_card_widget.dart';

class MealDetailsInstructionsWidget extends StatelessWidget {
  final List<String> steps;

  MealDetailsInstructionsWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
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
                  Icons.description_rounded,
                  color: primaryColor,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Instructions',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Steps List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return MealDetailsStepCardWidget(
                index: index,
                step: steps[index],
                isLast: index == steps.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
