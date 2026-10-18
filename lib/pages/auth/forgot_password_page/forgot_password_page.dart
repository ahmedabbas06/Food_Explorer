import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/auth_footer_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_button_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_email_field_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_header_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    await authProvider.forgotPassword(emailController.text.trim());

    if (!mounted) return;

    if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage!)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent successfully.')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 50.h),

                ForgotPasswordHeader(),

                SizedBox(height: 36.h),

                ForgotPasswordEmailField(controller: emailController),

                SizedBox(height: 24.h),

                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ForgotPasswordButton(
                      isLoading: authProvider.isLoading,
                      onPressed: resetPassword,
                    );
                  },
                ),

                SizedBox(height: 24.h),

                AuthFooterWidget(
                  text: 'Remember your password?',
                  actionText: 'Login',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
