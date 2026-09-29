import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AlreadyHaveAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AlreadyHaveAccountButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(color: Color(0xFFD4BBB1), fontSize: 14),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: onPressed,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
