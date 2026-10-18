import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/pages/navigation/widgets/floating_bottom_nav_widget.dart';

import '../favourite/favourite_page.dart';
import '../home/home_page.dart';
import '../settings_pages/setting_page/settings_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => BottomNavPageState();
}

class BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomePage(), FavouritePage(), SettingsPage()];

    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(child: pages[currentIndex]),
          if (!isKeyboardOpen)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 18.h,
              child: FloatingBottomNav(
                currentIndex: currentIndex,
                onItemSelected: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
