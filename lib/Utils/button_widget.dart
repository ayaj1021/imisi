import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:scaled_size/scaled_size.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    required this.width,
    this.border,
    this.textColor,
  });

  final String text;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final double width;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 48.rh,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: AppStyles.buttonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
