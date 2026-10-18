import 'package:flutter/material.dart';

class PrivacyConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final bool isDanger;

  PrivacyConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confirmColor = isDanger ? Color(0xFFE85D5D) : Color(0xFFFF8A3D);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: TextStyle(color: confirmColor, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
