// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefixIcon;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppStyles.bodyText1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppStyles.bodyText2.copyWith(color: AppColors.textColor.withOpacity(0.7)),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white.withOpacity(0.9),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}