import 'package:flutter/material.dart';

class CustomNavigation {
  static void pushReplacement(BuildContext context, Widget newScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget newScreen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
          (Route<dynamic> route) => false,
    );
  }

  static void push(BuildContext context, Widget newScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }
}
