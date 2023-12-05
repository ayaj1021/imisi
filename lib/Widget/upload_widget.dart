import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:scaled_size/scaled_size.dart';

class UpLoadButton extends StatelessWidget {
  final String image;
  final String subTitle;
  final String title;
  final VoidCallback onTap;
  final Color selectColor;
  const UpLoadButton({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
    required this.onTap,
    required this.selectColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.upLoadContainerColor,
        ),
        child: Row(
          children: [
            Image.asset(image, height: 25.rh),
            gapWidth(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.title2.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                gapHeight(3),
                Text(
                  subTitle,
                  style: AppStyles.captionText.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.circle,
              size: 18,
              color: selectColor,
            ),
          ],
        ),
      ),
    );
  }
}
