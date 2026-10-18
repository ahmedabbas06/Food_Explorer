import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsYoutubeWidget extends StatelessWidget {
  final String youtubeUrl;
  final String imageUrl;

  const MealDetailsYoutubeWidget({
    super.key,
    required this.youtubeUrl,
    required this.imageUrl,
  });

  Future<void> openYoutubeUrl(BuildContext context, String rawUrl) async {
    final cleanUrl = rawUrl.trim();
    final uri = Uri.tryParse(cleanUrl);

    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid YouTube video link.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open YouTube link.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch YouTube application.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (youtubeUrl.trim().isEmpty || !youtubeUrl.startsWith('http')) {
      return SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.play_circle_fill_rounded,
                  color: primaryColor,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Watch on YouTube',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          GestureDetector(
            onTap: () => openYoutubeUrl(context, youtubeUrl),
            child: Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black45,
                        child: Center(
                          child: Icon(
                            Icons.video_library_rounded,
                            color: Colors.white54,
                            size: 40.r,
                          ),
                        ),
                      );
                    },
                  ),

                  Container(color: Colors.black.withValues(alpha: 0.45)),

                  Center(
                    child: Container(
                      width: 54.r,
                      height: 54.r,
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 36.r,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.open_in_new_rounded,
                        color: Colors.white,
                        size: 16.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
