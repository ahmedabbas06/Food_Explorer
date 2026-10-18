import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;

  const ProfileAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFFFF8A3D);

    return Center(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withOpacity(0.12),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.35),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.10),
                  blurRadius: 25,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              color: Color(0xFFFF8A3D),
              size: 52,
            ),
          ),
          SizedBox(height: 14),
          Text(
            name.isEmpty ? 'Profile' : name,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your personal account',
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
