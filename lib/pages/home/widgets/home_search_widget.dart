import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final bool isSearching;
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;

  const HomeSearchWidget({
    super.key,
    required this.searchController,
    required this.isSearching,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 15.sp,
              ),
              onSubmitted: onSearch,
              onChanged: (text) {
                if (text.isEmpty && isSearching) {
                  onClear();
                } else {
                  onSearch(text);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search for recipes...',
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20.r,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 18.r,
                        ),
                        onPressed: onClear,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 10.w),

        // Orange Search Action Button
        GestureDetector(
          onTap: () {
            onSearch(searchController.text);
          },
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.search, color: Colors.white, size: 24.r),
          ),
        ),
      ],
    );
  }
}
