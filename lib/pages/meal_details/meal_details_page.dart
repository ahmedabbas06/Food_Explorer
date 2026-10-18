import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import '../../api_service/meal_api/meal_api.dart';
import 'widgets/meal_details_header_widget.dart';
import 'widgets/meal_details_ingredients_grid_widget.dart';
import 'widgets/meal_details_instructions_widget.dart';
import 'widgets/meal_details_source_widget.dart';
import 'widgets/meal_details_youtube_widget.dart';

class MealDetailsPage extends StatefulWidget {
  final MealModel meal;

  MealDetailsPage({super.key, required this.meal});

  @override
  State<MealDetailsPage> createState() => MealDetailsPageState();
}

class MealDetailsPageState extends State<MealDetailsPage> {
  late List<String> steps;

  MealModel? mealDetails;
  bool isLoading = true;
  String? errorMessage;

  final MealApi mealApi = MealApi();

  @override
  void initState() {
    super.initState();

    steps = parseSteps(widget.meal.instructions);

    getMealDetails();
  }

  /// Splits raw instructions into clean steps without creating fake single-number steps
  List<String> parseSteps(String raw) {
    if (raw.trim().isEmpty) return [];

    final standaloneNumber = RegExp(
      r'^(step\s*)?\d+[\s:.\-]*$',
      caseSensitive: false,
    );
    final leadingNumberPrefix = RegExp(
      r'^(step\s*)?\d+[\s:.\-]+\s*',
      caseSensitive: false,
    );

    final rawLines = raw.split(RegExp(r'\r?\n'));
    final List<String> cleanSteps = [];

    for (final line in rawLines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      if (standaloneNumber.hasMatch(trimmed)) continue;

      final stripped = trimmed.replaceFirst(leadingNumberPrefix, '').trim();
      if (stripped.isNotEmpty && !standaloneNumber.hasMatch(stripped)) {
        cleanSteps.add(stripped);
      }
    }

    if (cleanSteps.isNotEmpty) {
      return cleanSteps;
    }

    // Fallback if raw text had no newlines: split on sentence ends
    return raw
        .split(RegExp(r'(?<=[.!?])\s+(?=[A-Z])'))
        .map((s) => s.trim())
        .map((s) => s.replaceFirst(leadingNumberPrefix, '').trim())
        .where((s) => s.isNotEmpty && !standaloneNumber.hasMatch(s))
        .toList();
  }

  Future<void> getMealDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final details = await mealApi.getMealDetails(widget.meal.id);

      if (!mounted) return;

      setState(() {
        mealDetails = details;
        isLoading = false;

        if (details != null && details.instructions.isNotEmpty) {
          steps = parseSteps(details.instructions);
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Network error. Could not fetch full recipe details.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final MealModel currentMeal = mealDetails ?? widget.meal;
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    Widget bodyContent;

    if (isLoading && mealDetails == null) {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: 16.h),
            Text(
              'Loading recipe details...',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    } else {
      bodyContent = SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Top Header Section (Image, Back, Favorite, Name, Badges, Tags)
            MealDetailsHeaderWidget(meal: currentMeal),

            // Error Banner with Retry Button if full details fetch failed
            if (errorMessage != null)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: primaryColor,
                      size: 20.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: getMealDetails,
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 2-Column Ingredients Grid Section (Hides if no ingredients!)
            if (currentMeal.ingredients.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: MealDetailsIngredientsGridWidget(
                  ingredients: currentMeal.ingredients,
                  measures: currentMeal.measures,
                ),
              ),

            // Instructions Step Guide Section (Hides if no instructions!)
            if (steps.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: MealDetailsInstructionsWidget(steps: steps),
              ),

            // YouTube Video Section (Hides if no YouTube link!)
            if (currentMeal.youtube.trim().isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: MealDetailsYoutubeWidget(
                  youtubeUrl: currentMeal.youtube,
                  imageUrl: currentMeal.image,
                ),
              ),

            // Source Link Section (Hides if no source link!)
            if (currentMeal.source.trim().isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: MealDetailsSourceWidget(sourceUrl: currentMeal.source),
              ),

            SizedBox(height: 36.h),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: bodyContent),
    );
  }
}
