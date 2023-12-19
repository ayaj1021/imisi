// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Provider/artiste_provider.dart';
import 'package:imisi/Screens/upload_steper.dart';
import 'package:imisi/Services/upload_file_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:provider/provider.dart';

class UpLoadFilePage extends StatefulWidget {
  final String artistName;
  final String songTitle;
  // final String artistName;
  // final String artistName;
  // final String artistName;

  const UpLoadFilePage(
      {super.key, required this.artistName, required this.songTitle});

  @override
  State<UpLoadFilePage> createState() => _UpLoadFilePageState();
}

class _UpLoadFilePageState extends State<UpLoadFilePage> {
  File? file;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAlertDialog(
                context,
                yesTextOnTap: () {
                  nextPage(const BasePage(), context);
                },
                message:
                    'Are you sure you want to leave this upload incomplete? You may lose any unsaved progress.',
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Consumer<ArtistProvider>(builder: (context, artist, child) {
        return Stack(
          children: [
            Center(
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
                        onTap: () async {
                          final FilePickerResult? result = await FilePicker
                              .platform
                              .pickFiles(type: FileType.audio);
                          if (result == null) return;
                          file = File(result.files.first.path!);

                          // artist.getImageGallery(context);
                          setState(() {
                            message = '${file!.path}';
                          });
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
                    child: Text(
                      file == null ? "You have not chosen any file" : message,
                      // artist.imageFile!.path,
                      style: AppStyles.bodyBold.copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonWidget(
                      onTap: () {
                        nextPage(
                            UploadStepperWidget(
                              file: file,
                            ),
                            context);
                      },
                      text: 'Add details',
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            artist.isUploading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }),
    );
  }

  void openFile(PlatformFile file) {
    //  OpenFile
  }
}
