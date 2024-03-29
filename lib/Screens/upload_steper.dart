// ignore_for_file: avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Services/upload_file_service.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/Widget/custom_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';
import '../Styles/app_colors.dart';

class UploadStepperWidget extends StatefulWidget {
  final String? audioPath;
  final int? fileType;

  const UploadStepperWidget(
      {super.key, this.audioPath, required this.fileType});

  @override
  State<UploadStepperWidget> createState() => _UploadStepperWidgetState();
}

class _UploadStepperWidgetState extends State<UploadStepperWidget> {
  late double percentage = 0.0;
  String? selectedImagePath;
  TextEditingController artistNameController = TextEditingController();
  TextEditingController songTitleController = TextEditingController();
  TextEditingController featuringController = TextEditingController();
  TextEditingController producersController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();

//<String?>
  Future<String?> pickImage() async {
    try {
      // Pick image file
      FilePickerResult? imageResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (imageResult != null) {
        // Return the path of the selected image file

        return imageResult.files.first.path;
      }
    } catch (error) {
      print('Error picking image: $error');
      // Handle the error
    }

    return null;
  }

  Future<void> pickImageFile() async {
    selectedImagePath = await pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.secondaryColor,
          leading: IconButton(
            onPressed: () {
              nextPage(const BasePage(), context);
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
        body: Consumer<UploadFileService>(
            builder: (context, uploadService, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Complete your upload",
                        style: AppStyles.agTitle3Bold
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "Follow these steps to complete upload ",
                        style: AppStyles.bodyRegularText
                            .copyWith(color: Colors.white),
                      ),
                      gapHeight(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await pickImageFile();
                            },
                            child: Container(
                              height: 120.rh,
                              width: 150.rw,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.upLoadContainerColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                child: selectedImagePath != null
                                    ? Image.file(
                                        File(selectedImagePath!),
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text(
                                          'Click to add cover image',
                                          style: TextStyle(
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          gapWidth(5),
                          const Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      gapHeight(15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            style: AppStyles.bodyRegularText
                                .copyWith(color: AppColors.onPrimaryColor),
                            controller: songTitleController,
                            decoration:
                                getDecoration("Song name", "*", Colors.red),
                          ),
                          TextField(
                            style: AppStyles.bodyRegularText
                                .copyWith(color: AppColors.onPrimaryColor),
                            controller: artistNameController,
                            decoration:
                                getDecoration("Artiste name", "*", Colors.red),
                          ),
                          TextField(
                            style: AppStyles.bodyRegularText
                                .copyWith(color: AppColors.onPrimaryColor),
                            controller: descriptionController,
                            decoration:
                                getDecoration("Description", "", Colors.red),
                          ),
                          TextField(
                            style: AppStyles.bodyRegularText
                                .copyWith(color: AppColors.onPrimaryColor),
                            controller: genreController,
                            decoration: getDecoration("Genre", "", Colors.red),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            // width: 135.rw,
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              children: [
                                // ButtonWidget(
                                //   onTap: () {
                                //     print('pressed');
                                //     uploadFile();
                                //   },
                                //   text: 'Finish',
                                //   color: AppColors.primaryColor,
                                // )
                                Consumer<UploadFileService>(
                                    builder: (context, uploadService, child) {
                                  return ButtonWidget(
                                    text: "Finish",
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      if (songTitleController.text.isEmpty ||
                                          artistNameController.text.isEmpty ||
                                          selectedImagePath!.isEmpty) {
                                        showSnackBar(
                                            context: context,
                                            message: "Pls fill in all details",
                                            isError: true);
                                      } else {
                                        widget.fileType == 0
                                            ? uploadService.sendSong(
                                                artist:
                                                    artistNameController.text,
                                                name: songTitleController.text,
                                                description:
                                                    descriptionController.text,
                                                genre: genreController.text,
                                                context,
                                                audioPath:
                                                    widget.audioPath ?? '',
                                                imagePath:
                                                    selectedImagePath ?? '',
                                              )
                                            : uploadService.sendVideo(
                                                artist:
                                                    artistNameController.text,
                                                name: songTitleController.text,
                                                description:
                                                    descriptionController.text,
                                                genre: genreController.text,
                                                context,
                                                videoPath:
                                                    widget.audioPath ?? '',
                                                imagePath:
                                                    selectedImagePath ?? '',
                                              );
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              uploadService.isUploading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "File upload in progress...",
                            style: AppStyles.bodyBold.copyWith(
                              color: AppColors.onPrimaryColor,
                            ),
                          )),
                          CustomProgressBar(
                            width: Provider.of<UploadFileService>(context)
                                .uploadTotal,
                            height: 30,
                            progress: Provider.of<UploadFileService>(context)
                                .uploadSent,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }));
  }

  InputDecoration getDecoration(String label, String type, Color typeColor) {
    return InputDecoration(
      labelStyle:
          AppStyles.bodyRegularText.copyWith(color: AppColors.onPrimaryColor),
      label: Row(
        children: [
          Text(label),
          gapWidth(5),
          Text(
            type,
            style: TextStyle(color: typeColor),
          )
        ],
      ),
    );
  }
}
