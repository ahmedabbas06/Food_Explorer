import 'package:flutter/material.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_button_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_create_account_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_forgot_password_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_header_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/signup_page.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../home/home_page.dart';
import '../signup_page/widgets/signup_auth_test_field_widget.dart';
import '../signup_page/widgets/signup_field_Label_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        LoginHeader(),

                        SizedBox(height: 34),

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
                          autofillHints: [AutofillHints.password],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 8),

                        ForgotPasswordText(),

                        SizedBox(height: 24),

                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return LoginButton(
                              isLoading: authProvider.isLoading,
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                await authProvider.login(
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

                        CreateAccountText(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => SignupPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
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
