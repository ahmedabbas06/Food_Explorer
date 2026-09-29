import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingImage extends StatelessWidget {
  final String assetPath;

  const OnboardingImage({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          color:  Color(0xFF2A211E),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 25,
              offset:  Offset(0, 12),
            ),
          ],
        ),
        padding:  EdgeInsets.all(25),
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}