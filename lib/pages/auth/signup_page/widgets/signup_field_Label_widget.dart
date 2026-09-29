import 'package:flutter/material.dart';

class AuthFieldLabel extends StatelessWidget {
  final String text;

  const AuthFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFFE4C7BC),
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
