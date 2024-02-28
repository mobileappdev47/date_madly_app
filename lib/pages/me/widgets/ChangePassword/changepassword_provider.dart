import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangePasswordProvider extends ChangeNotifier {
  TextEditingController currentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureText = true;

  bool confirmPass = true;

  String passwordError = '';
  String confirmPasswordError = '';
  String currentError = '';

  currentpassValidation() {
    if (currentController.text.trim() == "") {
      // setState(() {
      currentError = 'Enter the current password';
      notifyListeners();
      //  });
      return false;
    } else if (currentController.text !=
        PrefService.getString(PrefKeys.password)) {
      currentError = 'current password is Not Match';
      notifyListeners();
    } else {
      //  setState(() {
      currentError = '';
      notifyListeners();
      //  });
      return true;
    }
  }

  passwordValidation() {
    if (passwordController.text.trim() == "") {
      // setState(() {
      passwordError = 'Enter the password';
      notifyListeners();
      //  });
      return false;
    } else {
      //  setState(() {
      passwordError = '';
      notifyListeners();
      //  });
      return true;
    }
  }

  confirmPasswordValidation() {
    if (confirmPasswordController.text.trim() == "") {
      //  setState(() {
      confirmPasswordError = 'Enter the Confirm password';
      notifyListeners();
      //});
      return false;
    } else if (confirmPasswordController.text != passwordController.text) {
      // setState(() {
      confirmPasswordError = 'Not match with Password';
      notifyListeners();
      //  });
      return true;
    } else {
      // setState(() {
      confirmPasswordError = '';
      notifyListeners();
      //  });
      return false;
    }
  }

  val() async {
    currentpassValidation();
    passwordValidation();
    confirmPasswordValidation();
  }

  validation() {
    val();
    if (currentError == '' &&
        passwordError == '' &&
        confirmPasswordError == '') {
      return true;
    } else {
      return false;
    }
  }
}
