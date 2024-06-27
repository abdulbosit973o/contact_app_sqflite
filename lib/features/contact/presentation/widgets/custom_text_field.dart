import 'package:flutter/material.dart';
import 'package:contact_app_sqflite/config/theme/color/light_color.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: LightColor.grey,
      obscureText: widget.isPassword ? !showPassword : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            fontFamily: 'PaynetB', color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: LightColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xff263238),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xff263238),
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xff000000),
          ),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        )
            : IconButton(
          icon: const Icon(
            Iconsax.close_square5,
            color: Color(0xff000000),
          ),
          onPressed: () {
            widget.controller.clear();
          },
        ),
      ),
      style: const TextStyle(color: Colors.black, fontFamily: 'PaynetB'),
    );
  }
}
