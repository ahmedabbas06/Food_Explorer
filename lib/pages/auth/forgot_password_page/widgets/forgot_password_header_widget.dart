import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: Color(0xFF342722),
            borderRadius: BorderRadius.circular(27),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(27),
            child: Transform.scale(
              scale: 1.75,
              child: Image.asset('assets/logo_app.png', fit: BoxFit.contain),
            ),
          ),
        ),

        SizedBox(height: 18),

        Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 27,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.3,
          ),
        ),

        SizedBox(height: 7),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Enter your email and we’ll send you a link\nto reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC8AEA4),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
