import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Authentication/wellcome_screen.dart';
import 'package:firebase_authentication/UI%20Screen/Home%20Screen/home_screen.dart';
import 'package:firebase_authentication/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (FirebaseAuth.instance.currentUser != null) {
    runApp(const MyAppLogIn());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: const WellComeScreen(),
      builder: EasyLoading.init(),
    );
  }
}

class MyAppLogIn extends StatelessWidget {
  const MyAppLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: const HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
