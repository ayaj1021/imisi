import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';


class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar(
      {super.key,
      required this.width,
      required this.height,
      required this.progress});
  final double width;
  final double height;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * progress,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.upLoadContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: progress,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${(progress.toStringAsFixed(0))}%",
                  // "${(progress / 100).toInt()}%",
                  style: TextStyle(
                    color: AppColors.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
