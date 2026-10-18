import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsSourceWidget extends StatelessWidget {
  final String sourceUrl;

  MealDetailsSourceWidget({super.key, required this.sourceUrl});

  Future<void> openSourceUrl(BuildContext context, String rawUrl) async {
    final cleanUrl = rawUrl.trim();
    final uri = Uri.tryParse(cleanUrl);

    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid recipe source link.'),
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
            content: Text('Could not open source link in browser.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch browser for source link.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sourceUrl.trim().isEmpty || !sourceUrl.startsWith('http')) {
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
                  Icons.link_rounded,
                  color: primaryColor,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'View Original Recipe',
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
            onTap: () => openSourceUrl(context, sourceUrl),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.link_rounded,
                      color: Colors.black,
                      size: 22.r,
                    ),
                  ),

                  SizedBox(width: 14.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View Original Recipe',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'See the full recipe details on source site',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 16.r,
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
