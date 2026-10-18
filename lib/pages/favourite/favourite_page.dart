import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:food_explorer/pages/favourite/widgets/favourite_header_widget.dart';
import 'favourite_store.dart';
import 'widgets/favourite_card_widget.dart';
import 'widgets/favourite_empty_widget.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: FavouriteHeader(),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ValueListenableBuilder<List<MealModel>>(
                valueListenable: FavouritesStore.instance.meals,
                builder: (context, meals, child) {
                  return meals.isEmpty
                      ? FavouriteEmptyWidget()
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                          itemCount: meals.length,
                          itemBuilder: (context, index) =>
                              FavouriteCardWidget(meal: meals[index]),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
