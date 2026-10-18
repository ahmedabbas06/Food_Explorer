import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import 'package:food_explorer/pages/favourite/favourite_store.dart';

class MealDetailsHeaderWidget extends StatelessWidget {
  final MealModel meal;

  MealDetailsHeaderWidget({super.key, required this.meal});

  String getCountryFlagEmoji(String areaName) {
    final cleanArea = areaName.trim().toLowerCase();
    switch (cleanArea) {
      // South America
      case 'argentina':
      case 'argentinian':
      case 'argentine':
        return '🇦🇷';
      case 'brazil':
      case 'brazilian':
        return '🇧🇷';
      case 'chile':
      case 'chilean':
        return '🇨🇱';
      case 'colombia':
      case 'colombian':
        return '🇨🇴';
      case 'peru':
      case 'peruvian':
        return '🇵🇪';
      case 'uruguay':
      case 'uruguayan':
        return '🇺🇾';
      case 'venezuela':
      case 'venezuelan':
        return '🇻🇪';
      case 'ecuador':
      case 'ecuadorian':
        return '🇪🇨';
      case 'bolivia':
      case 'bolivian':
        return '🇧🇴';
      case 'paraguay':
      case 'paraguayan':
        return '🇵🇾';

      // Africa
      case 'egypt':
      case 'egyptian':
        return '🇪🇬';
      case 'morocco':
      case 'moroccan':
        return '🇲🇦';
      case 'tunisia':
      case 'tunisian':
        return '🇹🇳';
      case 'algeria':
      case 'algerian':
        return '🇩🇿';
      case 'south africa':
      case 'south african':
        return '🇿🇦';
      case 'nigeria':
      case 'nigerian':
        return '🇳🇬';
      case 'kenya':
      case 'kenyan':
        return '🇰🇪';
      case 'ethiopia':
      case 'ethiopian':
        return '🇪🇹';
      case 'ghana':
      case 'ghanaian':
        return '🇬🇭';

      // Asia
      case 'saudi':
      case 'saudi arabia':
      case 'saudi arabian':
      case 'saudiarabian':
        return '🇸🇦';
      case 'china':
      case 'chinese':
        return '🇨🇳';
      case 'japan':
      case 'japanese':
        return '🇯🇵';
      case 'india':
      case 'indian':
        return '🇮🇳';
      case 'thailand':
      case 'thai':
        return '🇹🇭';
      case 'vietnam':
      case 'vietnamese':
        return '🇻🇳';
      case 'indonesia':
      case 'indonesian':
        return '🇮🇩';
      case 'malaysia':
      case 'malaysian':
        return '🇲🇾';
      case 'korea':
      case 'south korea':
      case 'korean':
      case 'south korean':
        return '🇰🇷';
      case 'pakistan':
      case 'pakistani':
        return '🇵🇰';
      case 'philippines':
      case 'filipino':
        return '🇵🇭';

      // Europe
      case 'italy':
      case 'italian':
        return '🇮🇹';
      case 'france':
      case 'french':
        return '🇫🇷';
      case 'spain':
      case 'spanish':
        return '🇪🇸';
      case 'germany':
      case 'german':
        return '🇩🇪';
      case 'united kingdom':
      case 'uk':
      case 'british':
      case 'english':
        return '🇬🇧';
      case 'greece':
      case 'greek':
        return '🇬🇷';
      case 'portugal':
      case 'portuguese':
        return '🇵🇹';
      case 'poland':
      case 'polish':
        return '🇵🇱';
      case 'netherlands':
      case 'dutch':
        return '🇳🇱';
      case 'turkey':
      case 'turkish':
        return '🇹🇷';
      case 'croatia':
      case 'croatian':
        return '🇭🇷';
      case 'ireland':
      case 'irish':
        return '🇮🇪';
      case 'russia':
      case 'russian':
        return '🇷🇺';
      case 'ukraine':
      case 'ukrainian':
        return '🇺🇦';

      // North & Central America & Caribbean
      case 'united states':
      case 'usa':
      case 'us':
      case 'american':
        return '🇺🇸';
      case 'canada':
      case 'canadian':
        return '🇨🇦';
      case 'mexico':
      case 'mexican':
        return '🇲🇽';
      case 'jamaica':
      case 'jamaican':
        return '🇯🇲';
      case 'cuba':
      case 'cuban':
        return '🇨🇺';
      case 'costa rica':
      case 'costa rican':
        return '🇨🇷';

      // Oceania
      case 'australia':
      case 'australian':
        return '🇦🇺';
      case 'new zealand':
      case 'kiwi':
        return '🇳🇿';
      case 'fiji':
      case 'fijian':
        return '🇫🇯';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);
    final flagEmoji = getCountryFlagEmoji(meal.area);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Image with Overlays
        Stack(
          children: [
            Container(
              height: 280.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Image.network(
                  meal.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black26,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 40.r,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Top Buttons Row
            Positioned(
              top: 12.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18.r,
                      ),
                    ),
                  ),

                  // Favorite Button
                  ValueListenableBuilder<List<MealModel>>(
                    valueListenable: FavouritesStore.instance.meals,
                    builder: (context, favoriteMeals, child) {
                      final isFav = FavouritesStore.instance.isFavourite(meal);
                      return GestureDetector(
                        onTap: () {
                          final wasFav = FavouritesStore.instance.isFavourite(
                            meal,
                          );
                          FavouritesStore.instance.toggle(meal);

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                wasFav
                                    ? 'Removed from favorites'
                                    : 'Added to favorites',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : primaryColor,
                            size: 20.r,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Title and Category/Area Badges
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Name
              Text(
                meal.name,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              // Category & Area Badges Row
              Row(
                children: [
                  if (meal.category.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_rounded,
                            color: primaryColor,
                            size: 16.r,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            meal.category,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],

                  if (meal.area.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: theme.dividerColor.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (flagEmoji.isNotEmpty)
                            Text(flagEmoji, style: TextStyle(fontSize: 16.sp))
                          else
                            Icon(
                              Icons.public_rounded,
                              color: theme.colorScheme.onSurfaceVariant,
                              size: 16.r,
                            ),
                          SizedBox(width: 6.w),
                          Text(
                            meal.area,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              // Tags Row (Only shown if strTags exists!)
              if (meal.tags.isNotEmpty) ...[
                SizedBox(height: 14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_offer_rounded,
                      color: primaryColor,
                      size: 18.r,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Tags',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: meal.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: theme.dividerColor.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
