import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

import '../../../Style/app_color.dart';
import '../../../Widget/button_global.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool otpClick = false;

  TextEditingController codeController = TextEditingController();

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
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(color: AppColor.titleColor, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(child: Lottie.asset('images/otp.json', height: 250)),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    'Enter the verification code we just sent on your email address.',
                    style: TextStyle(color: AppColor.darkGreyColor, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  controller: codeController,
                  length: 6,
                ),
                const SizedBox(
                  height: 40,
                ),
                ButtonGlobal(textButton: 'Verify', buttonDecoration: myButtonDecoration, buttonTextColor: Colors.red, onPressed: ({})),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(text: 'Didn\'t received code?'),
                            TextSpan(text: 'Resend', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
