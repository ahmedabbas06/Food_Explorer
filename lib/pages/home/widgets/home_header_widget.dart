import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const HomeHeaderWidget({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akelaty',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
