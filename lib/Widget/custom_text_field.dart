import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Utils/text_field_decoration.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon, this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText!,
      controller: controller,
      style: GoogleFonts.inter(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: GoogleFonts.inter(color: Colors.grey),
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: TextFieldDecoration().focusBorder,
      ),
    );
  }
}
