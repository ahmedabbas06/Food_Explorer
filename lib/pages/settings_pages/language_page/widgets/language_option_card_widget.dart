import 'package:flutter/material.dart';

class LanguageOptionCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFFFF8A3D);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.10)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : theme.dividerColor.withValues(alpha: 0.15),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.12),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? primaryColor
                      : theme.colorScheme.onSurfaceVariant,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 19,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
