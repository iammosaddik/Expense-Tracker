import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Authentication/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Helper/validator.dart';
import '../Style/app_color.dart';
import '../Style/url_launcher.dart';
import '../UI Screen/Home Screen/home_screen.dart';
import '../Widget/button_global.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool rememberMe = false;
  bool isButtonPressed = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submite() {
    final isvalid = _formKey.currentState?.validate();
    if (!isvalid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  // Future<FirebaseApp> _initializeFireBase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => HomeScreen(user: user),
  //       ),
  //     );
  //   }
  //   return firebaseApp;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // AppTextField(
                //   textFieldType: TextFieldType.PASSWORD,
                //   validator: (value) {
                //     if (value!.isEmpty) return 'Password can\'t be empty';
                //     if (value.length > 6) return 'Must be 6 ';
                //   },
                // ),
                // lottie animation start Code............
                Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: Lottie.asset('images/login.json'),
                ),
                // lottie animation end Code.................
                const SizedBox(
                  height: 20,
                ),
                // AppTextField start Code ................
                GetTextField(
                  validator: (value) => CustomValidator.validateEmail(email: value),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  hintText: 'Email',
                  labelText: 'Enter Your Email',
                  textFieldType: TextFieldType.EMAIL,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                GetTextField(
                  validator: (value) => CustomValidator.validateInPassword(password: value),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  hintText: 'Password',
                  labelText: 'Enter Your Password',
                  textFieldType: TextFieldType.PASSWORD,
                  controller: passwordController,
                ),
                // AppTextField end Code ............
                const SizedBox(
                  height: 20,
                ),
                // Remember me and forgot password start code ........
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              if (rememberMe == false) {
                                rememberMe = true;
                              } else if (rememberMe == true) {
                                rememberMe = false;
                              }
                            });
                          },
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(color: AppColor.darkGreyColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => const ForgotPassword().launch(context),
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: AppColor.darkGreyColor, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                // Remember me and forgot password end code ........
                const SizedBox(
                  height: 30,
                ),
                // Sign In start code ................
                ButtonGlobal(
                    textButton: 'Log In',
                    buttonDecoration: myButtonDecoration.copyWith(color: isButtonPressed ? Colors.black : AppColor.buttonColor),
                    buttonTextColor: isButtonPressed ? Colors.white : AppColor.borderColor,
                    onPressed: () async {
                      _submite();
                      if (_formKey.currentState!.validate()) {
                        try {
                          EasyLoading.show(status: 'Signing In .....');
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                          EasyLoading.showSuccess('Sign In successfully');
                          if (credential.user != null) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            EasyLoading.showError('User Not Found');
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            EasyLoading.showError('Wrong Password');
                            print('Wrong password provided for that user.');
                          }
                        }
                      }
                      setState(() {
                        if (isButtonPressed == false) {
                          isButtonPressed = true;
                        } else if (isButtonPressed == true) {
                          isButtonPressed = false;
                        }
                      });
                    }),
                // Sign In end code .................
                const SizedBox(
                  height: 60,
                ),
                // Browser Link code start .............
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LinkButton(
                      image: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.blue,
                          size: 34,
                        ),
                      ),
                      buttonDecoration: myButtonDecoration.copyWith(
                        color: Colors.white,
                      ),
                    ).onTap(() {
                      UrlLauncher().launcheURL('www.facebook.com');
                    }),
                    const SizedBox(
                      width: 8,
                    ),
                    LinkButton(
                      image: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("images/google.png"),
                      ),
                      buttonDecoration: myButtonDecoration.copyWith(
                        color: Colors.white,
                      ),
                    ).onTap(() {
                      UrlLauncher().launcheURL('www.google.com');
                    }),
                    const SizedBox(
                      width: 8,
                    ),
                    LinkButton(
                      buttonDecoration: myButtonDecoration.copyWith(
                        color: Colors.white,
                      ),
                      image: const Icon(
                        Icons.apple,
                        color: AppColor.darkColor,
                        size: 44,
                      ),
                    ).onTap(() {
                      UrlLauncher().launcheURL('www.apple.com');
                    }),
                  ],
                ),
                // Browser Link code start .............
                const SizedBox(
                  height: 40,
                ),
                //bottom code start here ...........
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      'Sign Up Here',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ).onTap(() => const SignUp().launch(context, isNewTask: Lottie.traceEnabled)),
                  ],
                )
                //bottom code end here ...........
              ],
            ),
          ),
        ),
      ),
    );
  }
}
