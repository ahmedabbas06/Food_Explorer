import 'package:flutter/material.dart';



class AuthFieldLabel extends StatelessWidget {
  final String text;

  const AuthFieldLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
