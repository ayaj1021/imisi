import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';


Future<dynamic> showModalBottomSheetWidget(
    BuildContext context, List<Widget> children) {
  return showModalBottomSheet(
      backgroundColor: AppColors.overlayColor,
      context: context,
      builder: (_) {
        return SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(children: children),
          ),
        );
      });
}
