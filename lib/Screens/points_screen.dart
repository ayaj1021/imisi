import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/navigator.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
//  Future points = GetPointsService.getPoints();
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
      body: SafeArea(child: 
      Container(), 
      // FutureBuilder<GetPointsService>(
      //       future:points ,
      //       builder: (context, snapshot) {
      //         final data = snapshot.data;
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(
      //             child: CircularProgressIndicator(
      //               color: AppColors.primaryColor,
      //             ),
      //           );
      //         } else if (snapshot.hasData) {
      //           Center(
      //               child: Text(
      //             'You have ${data!["points"]}points yet ',
      //             style: AppStyles.bodyBold.copyWith(
      //               color: AppColors.onPrimaryColor,
      //             ),
      //           ));
      //         }
      //         return Container();
      //       },),
      ),
    );
  }
}
