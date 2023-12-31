// ignore_for_file: unnecessary_string_interpolations

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:imisi/Screens/upload_steper.dart';

import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Widget/button_widget.dart';


class UpLoadFilePage extends StatefulWidget {
  // final String artistName;
  // final String songTitle;
  // final String artistName;
  // final String artistName;
  // final String artistName;

  const UpLoadFilePage({
    super.key,
    // required this.artistName, required this.songTitle
  });

  @override
  State<UpLoadFilePage> createState() => _UpLoadFilePageState();
}

class _UpLoadFilePageState extends State<UpLoadFilePage> {
  // File? file;
  // String message = '';
  String? selectedAudioPath;
  // <String?>
  Future<String?> pickAudio() async {
    try {
      // Pick audio file
      FilePickerResult? audioResult = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (audioResult != null) {
        // Return the path of the selected audio file
        return audioResult.files.first.path;
      }
    } catch (error) {
      print('Error picking audio: $error');
      // Handle the error
    }

    return null;
  }

  Future<void> pickAudioFile() async {
    selectedAudioPath = await pickAudio();
    setState(() {});
  }

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
      body: 
         Stack(
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
                          await pickAudioFile();
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
                      selectedAudioPath == null
                          ? "You have not chosen any file"
                          : selectedAudioPath ?? '',
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
                              audioPath: selectedAudioPath,
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
            // artist.isUploading
            //     ? Container(
            //         color: Colors.black.withOpacity(0.5),
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       )
            //     : const SizedBox(),
          ],
        )
      
    );
  }

  void openFile(PlatformFile file) {
    //  OpenFile
  }
}
