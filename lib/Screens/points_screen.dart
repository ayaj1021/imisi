import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Services/show_points_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:scaled_size/scaled_size.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  Future getPoints = ShowPointsService().showPoints();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
            onPressed: () {
              nextPage(const BasePage(), context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: FutureBuilder(
                future: getPoints,
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 63.rh,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFF2E2E2E),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your points',
                                    style: AppStyles.bodyBold.copyWith(
                                        color: AppColors.onPrimaryColor),
                                  ),
                                  Text(
                                    data["points"].toString(),
                                    style: AppStyles.agTitle3Bold.copyWith(
                                        color: AppColors.onPrimaryColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                  width: 128,
                                  child: ButtonWidget(
                                    text: 'Redeem points',
                                    color: AppColors.disabledButtonColor,
                                    textColor: AppColors.hintTextColor,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
          ),
        ),
      ),
    );
  }
}
