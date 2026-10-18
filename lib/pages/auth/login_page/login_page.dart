import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_button_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_create_account_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_forgot_password_widget.dart';
import 'package:food_explorer/pages/auth/login_page/widgets/login_header_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/signup_page.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../navigation/bottom_nav_page.dart';
import '../signup_page/widgets/signup_auth_test_field_widget.dart';
import '../signup_page/widgets/signup_field_Label_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40.h,
                    maxWidth: 430.w,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginHeader(),

                        SizedBox(height: 28.h),

                        AuthFieldLabel(text: 'Email Address'),

                        SizedBox(height: 8.h),

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

                        SizedBox(height: 18.h),

                        AuthFieldLabel(text: 'Password'),

                        SizedBox(height: 8.h),

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

                        SizedBox(height: 8.h),

                        ForgotPasswordText(),

                        SizedBox(height: 20.h),

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
                                      builder: (context) => BottomNavPage(),
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),

                        CreateAccountText(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
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
