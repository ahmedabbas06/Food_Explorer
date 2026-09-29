import 'package:flutter/material.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/auth_footer_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_button_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_email_field_widget.dart';
import 'package:food_explorer/pages/auth/forgot_password_page/widgets/forgot_password_header_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    await authProvider.forgotPassword(emailController.text.trim());

    if (!mounted) return;

    if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(authProvider.errorMessage!)));

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset email sent successfully.')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111114),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 70),

                ForgotPasswordHeader(),

                SizedBox(height: 48),

                ForgotPasswordEmailField(controller: emailController),

                SizedBox(height: 28),

                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ForgotPasswordButton(
                      isLoading: authProvider.isLoading,
                      onPressed: _resetPassword,
                    );
                  },
                ),

                SizedBox(height: 28),

                AuthFooterWidget(
                  text: 'Remember your password?',
                  actionText: 'Login',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
