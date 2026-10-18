import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/settings_pages/profile_page/profile_page.dart';
import 'package:food_explorer/pages/settings_pages/setting_page/widgets/settings_card_widget.dart';
import 'package:food_explorer/pages/settings_pages/setting_page/widgets/settings_footer_widget.dart';
import 'package:food_explorer/pages/settings_pages/setting_page/widgets/settings_header_widget.dart';

import '../privacy_page/privacy_page.dart';
import '../theme_page/theme_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsHeader(),

              SizedBox(height: 24.h),

              Text(
                'App preferences & account',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 14.h),

              SettingsCard(
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                subtitle: 'Manage your personal information',
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),

              SettingsCard(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Customize your appearance',
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ThemePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),

/*
              SettingsCard(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'Choose your preferred language',
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),
*/

              SettingsCard(
                icon: Icons.lock_outline_rounded,
                title: 'Privacy',
                subtitle: 'Manage your privacy settings',
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => PrivacyPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),

              SettingsCard(
                icon: Icons.star_outline_rounded,
                title: 'Rate App',
                subtitle: 'Enjoying Akelaty ?',
                onTap: () {
                  showComingSoonSnackBar(
                    context,
                    title: 'Rate App',
                  );
                },
              ),

              SettingsCard(
                icon: Icons.share_outlined,
                title: 'Share App',
                subtitle: 'Share Akelaty with friends',
                onTap: () {
                  showComingSoonSnackBar(
                    context,
                    title: 'Share App',
                  );
                },
              ),

              SizedBox(height: 24.h),

              SettingsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

void showComingSoonSnackBar(
  BuildContext context, {
  required String title,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: Color(0xFFFF8A3D).withOpacity(0.25),
          ),
        ),
        content: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: Color(0xFFFF8A3D).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.construction_rounded,
                color: Color(0xFFFF8A3D),
                size: 20.r,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    'This feature is coming soon.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ),
    );
}
