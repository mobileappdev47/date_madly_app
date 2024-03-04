import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  bool obscureText = true;

  bool confirmPass = true;

  String email = '';
  String name = '';
  String dob = '';
  String password = '';
  String confirmPassword = '';
  String type = '';

  String emailError = '';
  String nameError = '';
  String dobError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String typeError = '';

  emailValidation() {
    if (emailController.text.trim() == "") {
      // errorToast(StringRes.enterEmailError.tr);
      // setState(() {
      emailError = 'Enter the Email Address';
      //  });
      notifyListeners();
      return false;
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        // setState(() {
        emailError = '';
        notifyListeners();
        // });

        return true;
      } else {
        // errorToast(StringRes.enterValidEmail.tr);
        // setState(() {
        emailError = 'Enter valid Email Address';
        notifyListeners();
        // });

        return false;
      }
    }
  }

  nameValidation() {
    if (nameController.text.trim() == "") {
      // errorToast(StringRes.enterFirstNameError.tr);
      // setState(() {
      nameError = 'Enter the Name';
      notifyListeners();
      //  });
      return false;
    } else {
      //  setState(() {
      nameError = '';
      notifyListeners();
      // });
      return true;
    }
  }

  dobValidation() {
    if (dobController.text.trim() == "") {
      //setState(() {
      dobError = 'Enter the Date of Birth';
      notifyListeners();
      // });
      return false;
    } else {
      //  setState(() {
      dobError = '';
      notifyListeners();
      // });
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
    emailValidation();
    nameValidation();
    dobValidation();
    passwordValidation();
    confirmPasswordValidation();
  }

  validation() {
    val();
    if (emailError == '' &&
        nameError == '' &&
        dobError == '' &&
        passwordError == '' &&
        confirmPasswordError == '') {
      return true;
    } else {
      return false;
    }
  }

  String data = "";
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      dobController.text = DateFormat('dd MMM, yyyy').format(picked);
      // setState(() {
      data = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
      // });

      // Handle the selected date, e.g., update a variable or display it
      print('Selected date: ${dobController.text}');
    }
  }
}
