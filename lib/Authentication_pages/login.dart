import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Services/auth_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snackBar.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/Widget/custom_text_field.dart';
import 'package:imisi/Authentication_pages/sign_up.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
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
                    "Log into your Account",
                    style: AppStyles.agTitle3Bold.copyWith(color: Colors.white),
                  ),
                  gapHeight(50),
                  CustomTextField(
                    hint: "Enter Email Address",
                    controller: emailController,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                  ),
                  gapHeight(10),
                  CustomTextField(
                    hint: "Enter Password",
                    controller: passwordController,
                    prefixIcon: Image.asset(
                      "assets/images/lock.png",
                      height: 30,
                      color: Colors.white,
                    ),
                    suffixIcon: Image.asset(
                      "assets/images/invisible.png",
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  gapHeight(20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: AppStyles.bodyRegularText.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  gapHeight(50),
                  Consumer<AuthService>(builder: (ctx, auth, child) {
                    return ButtonWidget(
                      text: auth.isLoggingIn == true ? "Loading..." : "Login",
                      color: AppColors.primaryColor,
                      onTap: () {
                        if(emailController.text.isEmpty || passwordController.text.isEmpty){
                          showSnackBar(context: context, message: "message", isError: true);
                        }else{
                          auth.login(
                            email: emailController.text,
                            password: passwordController.text,
context: context
                          );
                        }

                      },
                    );
                  }),
                  gapHeight(20),
                  InkWell(
                    onTap: () {
                      nextPage(const SignUpPage(), context);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have account? ",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: AppStyles.bodyRegularText.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  gapHeight(20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
