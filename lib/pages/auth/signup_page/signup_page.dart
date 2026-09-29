import 'package:flutter/material.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_already_have_account_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_button_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_header_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../home/home_page.dart';
import '../login_page/widgets/login_auth_text_field_widget.dart';
import '../login_page/widgets/login_field_label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111114),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: LayoutBuilder(
            builder: (context, raints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: raints.maxHeight - 40,
                    maxWidth: 430,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SignupHeader(),

                        SizedBox(height: 32),

                        AuthFieldLabel(text: 'Email Address'),

                        SizedBox(height: 9),

                        AuthTextField(
                          controller: emailController,
                          hintText: 'epicurean@gmail.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 22),

                        AuthFieldLabel(text: 'Password'),

                        SizedBox(height: 9),

                        AuthTextField(
                          controller: passwordController,
                          hintText: '••••••••••••',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          autofillHints: [AutofillHints.newPassword],
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 28),

                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return SignupButton(
                              isLoading: authProvider.isLoading,
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                await authProvider.signup(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );

                                if (!context.mounted) return;

                                if (authProvider.errorMessage != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authProvider.errorMessage!),
                                    ),
                                  );

                                  return;
                                }

                                if (authProvider.currentUser != null) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomePage(),
                                    ),
                                        (route) => false,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: 24),

                        AlreadyHaveAccountButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
