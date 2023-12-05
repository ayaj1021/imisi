import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.border,
    this.textColor,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.height,
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
