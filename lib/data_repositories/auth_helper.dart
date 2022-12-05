import 'dart:developer';

import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on Exception catch (e) {
      AppRouter.appRouter
          .showCustomDialoug('Error in registeration', e.toString());
    }
  }

  Future<bool?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on Exception catch (e) {
      AppRouter.appRouter
          .showCustomDialoug('Error in Authentication', e.toString());
    }
  }

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  // resetPassword(String email) async {}
  // verifyEmail(String email) async {}
}
