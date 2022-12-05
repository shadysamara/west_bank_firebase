import 'dart:developer';

import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repositories/auth_helper.dart';
import 'package:firebase_app/auth/screens/main_screen.dart';
import 'package:firebase_app/auth/screens/sign_in_screen.dart';
import 'package:firebase_app/data_repositories/firestore_helper.dart';
import 'package:firebase_app/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  late String email;
  late String password;
  saveEmail(String email) {
    this.email = email;
  }

  savePassword(String password) {
    this.password = password;
  }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return "Required field";
    } else if (!(isEmail(email))) {
      return "Incorrect email syntax";
    }
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return "Required field";
    } else if (password.length <= 6) {
      return 'Error, the password must be larger than 6 letters';
    }
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  String? phoneValidation(String content) {
    if (!isNumeric(content)) {
      return "InCorrect phone number syntax";
    }
  }

  signIn() async {
    if (signInKey.currentState!.validate()) {
      signInKey.currentState!.save();
      bool? result = await AuthHelper.authHelper
          .signIn(loginEmailController.text, passwordLoginController.text);
      if (result != null && result) {
        AppUser appUser = await FirestoreHelper.firestoreHelper
            .getUserFromFirestore(loginEmailController.text);
        log(appUser.toJson());
      }
    }
  }

  SignUp() async {
    if (signUpKey.currentState!.validate()) {
      bool? result = await AuthHelper.authHelper.signUp(
          registerEmailController.text, passwordRegisterController.text);
      if (result != null && result) {
        FirestoreHelper.firestoreHelper.addNewUser(AppUser(
            email: registerEmailController.text,
            userName: userNameController.text,
            phoneNumber: phoneController.text));
        // AppRouter.appRouter.goToWidgetAndReplace(MainScreen());
      }
    }
  }

  checkUser() {
    bool isLogged = AuthHelper.authHelper.checkUser();
    if (isLogged) {
      AppRouter.appRouter.goToWidgetAndReplace(MainScreen());
    } else {
      AppRouter.appRouter.goToWidgetAndReplace(SignInScreen());
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.goToWidgetAndReplace(SignInScreen());
  }
}
