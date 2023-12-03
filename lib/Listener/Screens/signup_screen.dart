import 'package:flutter/material.dart';
import 'package:imisi/Listener/Screens/login_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/button_widget.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';

import 'package:imisi/Utils/text_form_field.dart';
import 'package:scaled_size/scaled_size.dart';

class ListenerSignup extends StatefulWidget {
  const ListenerSignup({super.key});

  @override
  State<ListenerSignup> createState() => _ListenerSignupState();
}

class _ListenerSignupState extends State<ListenerSignup> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscureText = true;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 40,
                    child: Image.asset(
                      'assets/logos/Imisi_logo1.png',
                    ),
                  ),
                ),
                gapHeight(23),
                Text(
                  'Create your account',
                  style: AppStyles.agTitle3Bold
                      .copyWith(color: AppColors.onPrimaryColor),
                ),
                gapHeight(40),
                AuthField(
                  obscureText: false,
                  hintText: 'Enter username',
                  prefixIcon: Icons.person_outline,
                  controller: userNameController,
                ),
                gapHeight(35),
                AuthField(
                  obscureText: false,
                  hintText: 'Enter email',
                  prefixIcon: Icons.person_outline,
                  controller: emailController,
                ),
                gapHeight(35),
                AuthField(
                  obscureText: isObscureText,
                  hintText: 'Enter password',
                  prefixIcon: Icons.person_outline,
                  controller: passwordController,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: isObscureText == true
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            size: 20,
                            color: AppColors.hintTextColor,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                  ),
                ),
                gapHeight(8),
                Row(
                  children: [
                    Text(
                      'Password should not be less than 6 characters long',
                      style: AppStyles.bodyRegularText.copyWith(
                        color: AppColors.hintTextColor,
                      ),
                    )
                  ],
                ),
                gapHeight(50),
                ButtonWidget(
                    onTap: () {},
                    color: AppColors.primaryColor,
                    text: 'Sign up',
                    textColor: AppColors.secondaryColor,
                    width: 335.rw),
                gapHeight(21),
                GestureDetector(
                  onTap: () => nextPage(const ListenerLogin(), context),
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: AppStyles.bodyRegularText.copyWith(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '  Login',
                            style: AppStyles.bodyRegularText.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
