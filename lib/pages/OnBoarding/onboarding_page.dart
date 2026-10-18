import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_page/login_page.dart';

class OnBoardingScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const OnBoardingScreen({
    super.key,
    required this.prefs,
  });

  static Color backgroundColor = Color(0xFF111114);
  static Color textColor = Color(0xFFE7E2E1);
  static Color secondaryTextColor = Color(0xFFD1B4A9);
  static Color primaryColor = Color(0xFFFF7200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: backgroundColor,

          pages: [
            PageViewModel(
              title: 'Discover Delicious Meals',
              body: 'Explore a variety of delicious recipes from around the world.',
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28.r),
                child: Transform.scale(
                  scale: 1.2,
                  child: Image.asset(
                    'assets/on1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              decoration: getPageDecoration(),
            ),

            PageViewModel(
              title: 'Find Your Favorite Recipes',
              body: "Search through different meals and discover recipes you'll love.",
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28.r),
                child: Transform.scale(
                  scale: 1.2,
                  child: Image.asset(
                    'assets/on2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              decoration: getPageDecoration(),
            ),

            PageViewModel(
              title: 'Cook Something Amazing',
              body: 'Get inspired, explore new flavors, and enjoy cooking at home.',
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28.r),
                child: Transform.scale(
                  scale: 1.0,
                  child: Image.asset(
                    'assets/on3.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              decoration: getPageDecoration(),
            ),
          ],

          showSkipButton: true,

          skip: Text(
            'Skip',
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          next: Icon(
            Icons.arrow_forward_rounded,
            color: primaryColor,
            size: 26.r,
          ),

          done: Text(
            'Get Started',
            style: TextStyle(
              color: primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          onDone: () => onIntroEnd(context),
          onSkip: () => onIntroEnd(context),

          dotsDecorator: DotsDecorator(
            size: Size(8.w, 8.h),
            activeSize: Size(24.w, 8.h),
            activeColor: primaryColor,
            color: Color(0xFF5B4A43),
            spacing: EdgeInsets.symmetric(horizontal: 4.w),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),

          globalFooter: SizedBox(height: 8.h),

          curve: Curves.easeInOut,

          animationDuration: 350,

          controlsMargin: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),

          controlsPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),

          showBackButton: false,
        ),
      ),
    );
  }

  void onIntroEnd(BuildContext context) async {
    await prefs.setBool('onboardingCompleted', true);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      pageColor: backgroundColor,

      imagePadding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),

      titlePadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),

      bodyPadding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 8.h,
      ),

      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),

      bodyTextStyle: TextStyle(
        color: secondaryTextColor,
        fontSize: 15.sp,
        height: 1.4,
      ),

      footerPadding: EdgeInsets.zero,
    );
  }
}