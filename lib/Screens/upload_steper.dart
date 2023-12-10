import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/Base/Basepages/UploadPages/send_file.dart';
import 'package:imisi/Base/Basepages/upload_pages.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:scaled_size/scaled_size.dart';

import '../Styles/app_colors.dart';

class UploadStepperWidget extends StatefulWidget {
  const UploadStepperWidget({super.key});

  @override
  State<UploadStepperWidget> createState() => _UploadStepperWidgetState();
}

class _UploadStepperWidgetState extends State<UploadStepperWidget> {
  TextEditingController artistNameController = TextEditingController();
  TextEditingController songTitleController = TextEditingController();
  TextEditingController featuringController = TextEditingController();
  TextEditingController producersController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  List type = [
    {"type": "Public"},
    {"type": "Private"}
  ];

  PageController controller = PageController(initialPage: 0);
  int? selectedIndex;
  List<Step> steps() => [
        Step(
            isActive: currentStep >= 0,
            label: const Text("Basic steps"),
            content: const Column(
              children: [
                TextField(),
                TextField(),
                TextField(),
                TextField(),
                TextField(),
              ],
            ),
            title: const Text("")),
        Step(
          isActive: currentStep >= 1,
          label: const Text("Release"),
          content: const Text("data"),
          title: const Text(""),
        ),
      ];
  int currentStep = 0;
  bool isSecondTab = false;
  @override
  void initState() {
    // currentPage = controller.page!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  nextPage(const UpLoadPage(), context);
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your song is uploaded",
                style: AppStyles.agTitle3Bold.copyWith(color: Colors.white),
              ),
              Text(
                "Follow these steps to complete upload ",
                style: AppStyles.bodyRegularText.copyWith(color: Colors.white),
              ),
              gapHeight(15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: AppColors.overlayColor,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSecondTab = false;
                        });
                        controller.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSecondTab
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                          border: Border.all(
                            color: isSecondTab
                                ? AppColors.upLoadContainerColor
                                : AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSecondTab = true;
                        });
                        controller.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSecondTab == true
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                          border: Border.all(
                            color: selectedIndex == 0
                                ? AppColors.upLoadContainerColor
                                : AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gapHeight(20),
              Expanded(
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> pages() => [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              TextField(
                style: AppStyles.bodyRegularText
                    .copyWith(color: AppColors.onPrimaryColor),
                controller: artistNameController,
                decoration: getDecoration("Artist name", "*", Colors.red),
              ),
              TextField(
                style: AppStyles.bodyRegularText
                    .copyWith(color: AppColors.onPrimaryColor),
                controller: songTitleController,
                decoration: getDecoration("Song title", "*", Colors.red),
              ),
              TextField(
                style: AppStyles.bodyRegularText
                    .copyWith(color: AppColors.onPrimaryColor),
                controller: featuringController,
                decoration: getDecoration("Featuring",
                    "(Separate names using comas)", AppColors.hintTextColor),
              ),
              TextField(
                style: AppStyles.bodyRegularText
                    .copyWith(color: AppColors.onPrimaryColor),
                controller: producersController,
                decoration: getDecoration("Producer(s)",
                    "(Separate names using comas)", AppColors.hintTextColor),
              ),
              TextField(
                style: AppStyles.bodyRegularText
                    .copyWith(color: AppColors.onPrimaryColor),
                controller: albumController,
                decoration: getDecoration("Album", "", Colors.red),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                width: 135.rw,
                child: ButtonWidget(
                  text: "Next",
                  onTap: () {
                    print(artistNameController.text);
                    // setState(() {
                    //   isSecondTab = true;
                    // });
                    // controller.nextPage(
                    //   duration: const Duration(milliseconds: 300),
                    //   curve: Curves.easeIn,
                    // );
                  },
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: type.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.upLoadContainerColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 18,
                          color: selectedIndex == index
                              ? AppColors.primaryColor
                              : AppColors.overlayColor,
                        ),
                        gapWidth(10),
                        Text(
                          type[index]["type"],
                          style: AppStyles.title2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Container(
              width: 135.rw,
              padding: const EdgeInsets.only(bottom: 50),
              child: ButtonWidget(
                text: "Finish",
                color: selectedIndex == null
                    ? AppColors.disabledButtonColor
                    : AppColors.primaryColor,
                onTap: () {
                  nextPage(const UpLoadFilePage(artistName: "", songTitle: ""),
                      context);
                },
              ),
            ),
          ],
        )
      ];

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
