import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ForgotPasswordEmailField extends StatelessWidget {
  final TextEditingController controller;

   const ForgotPasswordEmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Email Address',
          style: TextStyle(
            color: Color(0xFFE4C7BC),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),

         SizedBox(height: 10),

        TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          style:  TextStyle(
            color: Color(0xFFE7E2E1),
            fontSize: 16,
          ),
          cursorColor: AppColors.primary,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email';
            }

            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor:  Color(0xFF1B1B1E),
            hintText: 'epicurean@gmail.com',
            hintStyle:  TextStyle(
              color: Color(0xFF725C53),
              fontSize: 15,
            ),
            prefixIcon:  Icon(
              Icons.email_outlined,
              color: Color(0xFFB99587),
              size: 22,
            ),
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primary.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: Colors.redAccent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}