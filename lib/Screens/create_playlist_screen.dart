import 'package:flutter/material.dart';
import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Services/create_playlist_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';

class CreatePlayListScreen extends StatefulWidget {
  const CreatePlayListScreen({super.key});

  @override
  State<CreatePlayListScreen> createState() => _CreatePlayListScreenState();
}

class _CreatePlayListScreenState extends State<CreatePlayListScreen> {
  TextEditingController playlistNameController = TextEditingController();
  @override
  void dispose() {
    playlistNameController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            isLoading == true
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                        gapHeight(15),
                        const Text(
                          "Creating playlist",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Give your playlist a name',
                        style: AppStyles.agTitle3Bold
                            .copyWith(color: AppColors.onPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.upLoadContainerColor))),
                          child: Center(
                            child: TextField(
                              style: AppStyles.agTitle3Bold.copyWith(
                                color: AppColors.onPrimaryColor,
                              ),
                              controller: playlistNameController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Create your playlist',
                                  hintStyle: AppStyles.agTitle3Bold.copyWith(
                                      color: AppColors.hintTextColor)),
                            ),
                          ),
                        ),
                      ),
                      gapHeight(52),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                onTap: () =>
                                    nextPage(const PlayListScreen(), context),
                                text: 'Cancel',
                                textColor: AppColors.onPrimaryColor,
                                border:
                                    Border.all(color: AppColors.onPrimaryColor),
                              ),
                            ),
                            gapWidth(15),
                            Expanded(
                              child: ButtonWidget(
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  CreatePlayListService()
                                      .createPlayList(
                                          name: playlistNameController.text,
                                          context: context)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                },
                                text: 'Create',
                                textColor: AppColors.secondaryColor,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
            // if (isLoading = true)
          ],
        ),
      )),
    );
  }
}
