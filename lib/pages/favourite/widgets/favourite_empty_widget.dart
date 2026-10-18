import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteEmptyWidget extends StatelessWidget {
  const FavouriteEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: 70.r,
            color: Color(0xff797270),
          ),
          SizedBox(height: 16.h),
          Text(
            "No favourite meals yet",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Add meals to your favourites",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
