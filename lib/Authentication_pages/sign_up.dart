import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Authentication_pages/login.dart';
import 'package:imisi/Services/auth_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/Widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obscureText = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Consumer<AuthService>(builder: (context, authService, child) {
          return Stack(
            children: [
              Padding(
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
                          "Create your Account",
                          style: AppStyles.agTitle3Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        gapHeight(50),
                        CustomTextField(
                          obscureText: false,
                          hint: "Enter username",
                          controller: nameController,
                          prefixIcon: Image.asset(
                            "assets/images/person.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        gapHeight(15),
                        CustomTextField(
                          obscureText: false,
                          hint: "Enter Email Address",
                          controller: emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                        gapHeight(15),
                        CustomTextField(
                          hint: "Enter Password",
                          obscureText: obscureText,
                          controller: passwordController,
                          prefixIcon: Image.asset(
                            "assets/images/lock.png",
                            height: 30,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: obscureText
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        gapHeight(10),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: AppColors.primaryColor,
                              size: 5,
                            ),
                            gapWidth(5),
                            Text(
                              "Password must be minimum of 6 characters",
                              style: AppStyles.captionText.copyWith(
                                color: AppColors.onPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        gapHeight(50),
                        ButtonWidget(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await AuthService()
                                .signUp(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                            )
                                .then((_) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          text: "Sign Up",
                          color: AppColors.primaryColor,
                        ),
                        gapHeight(20),
                        InkWell(
                          onTap: () {
                            nextPage(const LoginPage(), context);
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
                                  text: "Login",
                                  style: GoogleFonts.inter(
                                    color: AppColors.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
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
              authService.isLoggingIn
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                          gapHeight(15),
                          const Text(
                            "Signing up...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
