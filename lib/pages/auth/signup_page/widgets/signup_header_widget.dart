import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

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
            'Create Your Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),

          SizedBox(height: 7),

          Text(
            'Join Food Explorer and discover amazing recipes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4C7BC),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
