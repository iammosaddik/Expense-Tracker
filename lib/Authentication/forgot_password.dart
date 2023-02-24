import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Style/app_color.dart';
import '../Widget/button_global.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool forgotClick = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  // void sendOtp() async {
  //   EmailAuth(sessionName: 'Test session');
  //   var res = await EmailAuth(sessionName: 'Test session').sendOtp(
  //     recipientMail: emailController.text,
  //   );
  //   if (res) {
  //     print('Sent Otp successfully');
  //   } else {
  //     print('We Can\'t sent Otp');
  //   }
  // }

  // void verifyOtp() {
  //   var res = EmailAuth(sessionName: 'Test session').validateOtp(
  //     recipientMail: emailController.text,
  //     userOtp: otpController.text,
  //   );
  //   if (res) {
  //     print('Otp Vitrified');
  //   } else {
  //     print('Invalid Otp');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.blue,
        ).onTap(() {
          Navigator.pop(context);
        }),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: AppColor.titleColor, fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Lottie.asset('images/forgot.json'),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(
                  'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                  style: TextStyle(color: AppColor.darkGreyColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: GetTextField(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  hintText: 'Email',
                  labelText: 'Enter Your Email',
                  textFieldType: TextFieldType.EMAIL,
                  controller: emailController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonGlobal(
                textButton: 'Sent Otp',
                buttonDecoration: myButtonDecoration.copyWith(color: AppColor.buttonColor),
                buttonTextColor: AppColor.borderColor,
                onPressed: () async {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) => Navigator.of(context).pop());
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Remember Password',
                        style: TextStyle(
                          color: AppColor.greyColor,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        ' LogIn',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ).onTap(
                        () => const SignIn().launch(context, isNewTask: true),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
