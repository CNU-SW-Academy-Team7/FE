import 'package:flutter/material.dart';

class MonthCalendarPageTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const MonthCalendarPageTextField({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
