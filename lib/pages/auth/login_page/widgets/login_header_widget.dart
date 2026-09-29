import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
            'Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),

          SizedBox(height: 7),

          Text(
            'Sign in to explore delicious recipes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4C7BC),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),

        ],
      ),
    );
  }
}
