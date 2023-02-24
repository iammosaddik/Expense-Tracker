import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Authentication/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Helper/validator.dart';
import '../Style/app_color.dart';
import '../Style/url_launcher.dart';
import '../Widget/button_global.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isButtonPressed = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isvalid = _formKey.currentState?.validate();
    if (!isvalid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // lottie animation start Code...........
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: Lottie.asset('images/signup1.json'),
                  ),
                  // lottie animation end Code................
                  const SizedBox(
                    height: 10,
                  ),
                  // AppTextField start Code ...................
                  GetTextField(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    validator: (value) => CustomValidator.validateName(name: value),
                    hintText: 'First Name',
                    labelText: 'Enter Your First Name',
                    textFieldType: TextFieldType.NAME,
                    controller: firstNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetTextField(
                    validator: (value) => CustomValidator.validateLastName(lastName: value),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: 'Last Name',
                    labelText: 'Enter Your Last Name',
                    textFieldType: TextFieldType.NAME,
                    controller: lastNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetTextField(
                    validator: (value) => CustomValidator.validateEmail(email: value),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.blue,
                    ),
                    hintText: 'Email',
                    labelText: 'Enter Your Email Address',
                    textFieldType: TextFieldType.EMAIL,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetTextField(
                    validator: (value) => CustomValidator.validatePhoneNumber(phoneNumber: value),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    hintText: 'Phone Number',
                    labelText: 'Enter Your Phone Number',
                    textFieldType: TextFieldType.PHONE,
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetTextField(
                    validator: (value) => CustomValidator.validateUpPassword(password: value),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    hintText: 'Password',
                    labelText: 'Enter Your Password',
                    textFieldType: TextFieldType.PASSWORD,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetTextField(
                    validator: (value) {
                      if (value.isEmptyOrNull) return 'Re-Password can\'t be empty';
                      if (passwordController.text != value) {
                        return 'Password didn\'t Match';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    hintText: 'Re-Password',
                    labelText: 'Enter Your Re-Password',
                    textFieldType: TextFieldType.PASSWORD,
                  ),
                  // AppTextField end Code .....................
                  const SizedBox(
                    height: 20,
                  ),
                  // Sign Up start code .......................
                  ButtonGlobal(
                      textButton: 'Sign Up',
                      buttonDecoration: myButtonDecoration.copyWith(color: isButtonPressed ? Colors.black : AppColor.buttonColor),
                      buttonTextColor: isButtonPressed ? Colors.white : AppColor.borderColor,
                      onPressed: () async {
                        _submit();
                        if (_formKey.currentState!.validate()) {
                          try {
                            EasyLoading.show(status: 'Signing Up .....');
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            EasyLoading.showSuccess('Sign Up successfully');
                            if (credential.user != null) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
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
                  // Sign Up end code .......................
                  const SizedBox(
                    height: 30,
                  ),
                  // Browser Link code start ...................
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
                  // Browser Link code end ...................
                  const SizedBox(
                    height: 60,
                  ),
                  //bottom code start here ...........
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'LogIn Now',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ).onTap(() => const SignIn().launch(context, isNewTask: true)),
                    ],
                  ),
                  //bottom code end here ...........
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
