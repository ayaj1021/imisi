import 'package:flutter/material.dart';
import 'package:imisi/Base/Basepages/UploadPages/upload_file_page.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/Widget/upload_widget.dart';

class UpLoadPage extends StatefulWidget {
  const UpLoadPage({super.key});

  @override
  State<UpLoadPage> createState() => _UpLoadPageState();
}

class _UpLoadPageState extends State<UpLoadPage> {
  List fileType = [
    {
      "title": "Song",
      "subTitle": "Upload your song",
      "image": "assets/images/music.png",
    },
    {
      "title": "Video",
      "subTitle": "Upload your Video",
      "image": "assets/images/video.png",
    },
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 40,
                child: Image.asset(
                  'assets/logos/Imisi_logo1.png',
                ),
              ),
              gapHeight(20),
              Text(
                "Please select type of file to upload",
                style: AppStyles.agTitle3Bold.copyWith(color: Colors.white),
              ),
              gapHeight(30),
              ListView.builder(
                shrinkWrap: true,
                itemCount: fileType.length,
                itemBuilder: (context, index) {
                  return UpLoadButton(
                    onTap: () {
                      setState(
                        () {
                          selectedIndex = index;
                        },
                      );
                    },
                    image: fileType[index]["image"],
                    title: fileType[index]["title"],
                    subTitle: fileType[index]["subTitle"],
                    selectColor: selectedIndex == index
                        ? AppColors.primaryColor
                        : AppColors.overlayColor,
                  );
                },
              ),
              gapHeight(30),
              SizedBox(
                width: 135,
                child: ButtonWidget(
                  text: "Next",
                  color: selectedIndex == null
                      ? AppColors.disabledButtonColor
                      : AppColors.primaryColor,
                  textColor: selectedIndex == null
                      ? AppColors.hintTextColor
                      : AppColors.disabledButtonColor,
                  onTap: () {
                    // nextPage(const UpLoadFilePage(), context);
                    selectedIndex == null
                        ? () {}
                        : nextPage(
                            UpLoadFilePage(
                              fileType: selectedIndex!,

                              
                              // fileType:fileType,
                              // artistName: '',
                              // songTitle: '',
                            ),
                            context);

                    //  Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const UploadStepperWidget(),
                    //     ),
                    //   );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
