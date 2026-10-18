import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_already_have_account_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_button_widget.dart';
import 'package:food_explorer/pages/auth/signup_page/widgets/signup_header_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../navigation/bottom_nav_page.dart';
import '../login_page/widgets/login_auth_text_field_widget.dart';
import '../login_page/widgets/login_field_label_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
                        SignupHeader(),

                        SizedBox(height: 24.h),

                        AuthFieldLabel(text: 'Full Name'),

                        SizedBox(height: 8.h),

                        AuthTextField(
                          controller: nameController,
                          hintText: 'Ahmed Mohamed',
                          prefixIcon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.name],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 18.h),

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
                          autofillHints: [AutofillHints.newPassword],
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24.h),

                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return SignupButton(
                              isLoading: authProvider.isLoading,
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                await authProvider.signup(
                                  nameController.text.trim(),
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
