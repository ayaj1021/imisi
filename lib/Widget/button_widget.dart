import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.color,
<<<<<<< HEAD:lib/Utils/button_widget.dart
   
=======
>>>>>>> aec8aa9e84b0637b11cfc1944d079e73c47de6f7:lib/Widget/button_widget.dart
    this.border,
    this.textColor,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
<<<<<<< HEAD:lib/Utils/button_widget.dart
  
=======

>>>>>>> aec8aa9e84b0637b11cfc1944d079e73c47de6f7:lib/Widget/button_widget.dart
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
<<<<<<< HEAD:lib/Utils/button_widget.dart
        height: 48.rh,
        width: double.infinity,
=======
        width: MediaQuery.of(context).size.height,
>>>>>>> aec8aa9e84b0637b11cfc1944d079e73c47de6f7:lib/Widget/button_widget.dart
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
