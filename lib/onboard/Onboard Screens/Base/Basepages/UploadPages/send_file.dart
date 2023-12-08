import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpLoadFilePage extends StatefulWidget {
  const UpLoadFilePage({super.key});

  @override
  State<UpLoadFilePage> createState() => _UpLoadFilePageState();
}

class _UpLoadFilePageState extends State<UpLoadFilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        actions: const [
          Icon(
            Icons.close,
            color: Colors.white,
          ),
          SizedBox(width: 15)
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Column(
          children: [
            gapHeight(30),
            SizedBox(
              height: 60,
              width: 40,
              child: Image.asset(
                'assets/logos/Imisi_logo1.png',
              ),
            ),
            gapHeight(20),
            Text(
              "Please select file to upload",
              style: AppStyles.agTitle3Bold.copyWith(color: Colors.white),
            ),
            gapHeight(30),
            Container(
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.overlayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    // getImageGallery().then((value) {
                    //   print(imageFile!.path);
                    //   postFile(file: imageFile!.path);
                    // });
                  },
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.add),
                      ),
                      gapHeight(15),
                      Text(
                        "Tap here to browse and add your file",
                        style: AppStyles.captionText.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child:
              // Text(
              //   imageFile == null ? "Empty" : imageFile!.path,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
