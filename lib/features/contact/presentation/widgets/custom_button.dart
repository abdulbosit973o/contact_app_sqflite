import 'package:flutter/material.dart';
import 'package:contact_app_sqflite/config/theme/color/light_color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightColor.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 15),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'PaynetB',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
