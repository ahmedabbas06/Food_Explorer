import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_page/login_page.dart';

class OnBoardingScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const OnBoardingScreen({
    super.key,
    required this.prefs,
  });

  static  Color backgroundColor = Color(0xFF111114);
  static  Color textColor = Color(0xFFE7E2E1);
  static  Color secondaryTextColor = Color(0xFFD1B4A9);
  static  Color primaryColor = Color(0xFFFF7200);

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
              body:
              'Explore a variety of delicious recipes from around the world.',
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Transform.scale(
                  scale: 1.3,
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
              body:
              "Search through different meals and discover recipes you'll love.",
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Transform.scale(
                  scale: 1.3,
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
              body:
              'Get inspired, explore new flavors, and enjoy cooking at home.',
              image: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Transform.scale(
                  scale: 1,
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

          skip:  Text(
            'Skip',
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          next:  Icon(
            Icons.arrow_forward_rounded,
            color: primaryColor,
            size: 28,
          ),

          done:  Text(
            'Get Started',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),

          dotsDecorator: DotsDecorator(
            size:  Size(8, 8),
            activeSize:  Size(24, 8),
            activeColor: primaryColor,
            color:  Color(0xFF5B4A43),
            spacing:  EdgeInsets.symmetric(horizontal: 4),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          globalFooter:  SizedBox(height: 8),

          curve: Curves.easeInOut,

          animationDuration: 350,

          controlsMargin:  EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),

          controlsPadding:  EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),

          showBackButton: false,
        ),
      ),
    );
  }

  void _onIntroEnd(BuildContext context) async {
    await prefs.setBool('onboardingCompleted', true);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }
  PageDecoration getPageDecoration() {
    return  PageDecoration(
      pageColor: backgroundColor,

      imagePadding: EdgeInsets.only(
        top: 30,
        left: 24,
        right: 24,
        bottom: 30,
      ),

      titlePadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 10,
      ),

      bodyPadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 8,
      ),

      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),

      bodyTextStyle: TextStyle(
        color: secondaryTextColor,
        fontSize: 17,
        height: 1.5,
      ),

      footerPadding: EdgeInsets.zero,
    );
  }
}