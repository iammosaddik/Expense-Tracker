import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseAuthHelper {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      EasyLoading.show(status: 'Signing Up...');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
      EasyLoading.showSuccess('Sign Up Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showError('Weak Password');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError('Email Already Use');
        print('The account already exists for that email.');
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }

    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      EasyLoading.show(status: 'Signing in...');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      EasyLoading.showSuccess('Sing in Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError('User Not Found');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError('Wrong Password');
        print('Wrong password provided.');
      }
    }
    return user;
  }
}
