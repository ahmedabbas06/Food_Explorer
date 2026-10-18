import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/settings_pages/theme_page/widgets/theme_footer_widget.dart';
import 'package:food_explorer/pages/settings_pages/theme_page/widgets/theme_header_widget.dart';
import 'package:food_explorer/pages/settings_pages/theme_page/widgets/theme_option_card_widget.dart';
import 'package:food_explorer/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  ThemePage({super.key});

  @override
  State<ThemePage> createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  ThemeMode selectedTheme = ThemeMode.dark;

  @override
  void initState() {
    super.initState();

    selectedTheme = context.read<ThemeProvider>().themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemeHeader(),

              SizedBox(height: 28.h),

              Text(
                'Appearance',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 4.h),

              Text(
                'Customize how Akelaty looks',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 22.h),

              ThemeOptionCard(
                icon: Icons.light_mode_rounded,
                title: 'Light',
                subtitle: 'Bright and clean appearance',
                isSelected: selectedTheme == ThemeMode.light,
                onTap: () {
                  setState(() {
                    selectedTheme = ThemeMode.light;
                  });
                },
              ),

              ThemeOptionCard(
                icon: Icons.dark_mode_rounded,
                title: 'Dark',
                subtitle: 'Easy on the eyes',
                isSelected: selectedTheme == ThemeMode.dark,
                onTap: () {
                  setState(() {
                    selectedTheme = ThemeMode.dark;
                  });
                },
              ),

              ThemeOptionCard(
                icon: Icons.brightness_auto_rounded,
                title: 'System',
                subtitle: 'Follow device settings',
                isSelected: selectedTheme == ThemeMode.system,
                onTap: () {
                  setState(() {
                    selectedTheme = ThemeMode.system;
                  });
                },
              ),

              SizedBox(height: 28.h),

              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ThemeProvider>().changeTheme(selectedTheme);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF8A3D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              ThemeFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
