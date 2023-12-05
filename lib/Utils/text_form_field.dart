import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      required this.prefixIcon,
      this.obscureText,
      required this.controller});
  final String hintText;
  final Widget? suffixIcon;
  final IconData prefixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      child: TextField(
          style: AppStyles.title2.copyWith(color: Colors.white),
          controller: controller,
          obscureText: obscureText!,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle:
                AppStyles.title2.copyWith(color: AppColors.hintTextColor),
            suffixIcon: suffixIcon,
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: AppColors.hintTextColor,
            ),
          )),
    );
  }
}
