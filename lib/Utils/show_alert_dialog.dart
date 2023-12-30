import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';

//showDialog()
showAlertDialog(BuildContext context,
    {required String message, required VoidCallback yesTextOnTap}) {
  return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: AppColors.alertDialogColor,
            content: Text(
              message,
              style: AppStyles.bodyBold.copyWith(
                color: Colors.white,
              ),
            ),
            contentPadding: const EdgeInsets.all(20),
            actions: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      height: 48,
                      width: 78,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No',
                          style: AppStyles.buttonText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    gapWidth(19),
                    GestureDetector(
                      onTap: yesTextOnTap,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                        height: 48,
                        width: 78,
                        child: Center(
                          child: Text(
                            'Yes',
                            style: AppStyles.buttonText
                                .copyWith(color: AppColors.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
}
