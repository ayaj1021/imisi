import 'package:flutter/material.dart';

import 'package:imisi/Utils/gap.dart';

class SecondOnboardPage extends StatelessWidget {
  const SecondOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/onboard_image2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              gapHeight(15),
              // Text(
              //   'Enjoy the best gospel music from your favorite gospel artiste',
              //   style: AppStyles.h5.copyWith(color: Colors.white),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
