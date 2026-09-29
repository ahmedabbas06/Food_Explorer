import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CreateAccountText extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateAccountText({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                color: Color(0xFFD4BBB1),
                fontSize: 14,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: onPressed,
                child: Text(
                  'Create Account',
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
