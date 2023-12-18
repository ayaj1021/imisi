import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Text(
          'This is Library page',
          style: AppStyles.bodyBold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
    );
  }
}
