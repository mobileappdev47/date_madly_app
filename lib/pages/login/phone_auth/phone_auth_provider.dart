import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneAuthProvider extends ChangeNotifier {
  final codeController = TextEditingController();
  final phoneController = TextEditingController();
  String countryCode = '';
  String _validationResult = '';
  String phone = '';
  String countryCodeError = '';
  String phoneError = '';

  String get validationResult => _validationResult;

  bool isValidPhoneNumber(String phoneNumber) {
    // Add your phone number validation logic here
    // For simplicity, let's check if the length is 10
    return phoneNumber.length == 10;
  }

  bool countryValidation() {
    if (codeController.text.trim() == "") {
      countryCodeError = 'Select the your Country Code';

      return false;
    } else {
      countryCodeError = '';

      return true;
    }
  }

  phoneValidation() {
    if (phoneController.text.trim() == '') {
      phoneError = 'Enter the Mobile Number';

      //return false;
    } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
        .hasMatch(phoneController.text)) {
      phoneError = 'Enter the valid number';
    } else {
      phoneError = '';
      notifyListeners();
     // return false;
    }
  }

  val() async {
    phoneValidation();
    //countryValidation();
  }

  validation() {
    val();
    if (phone == '') {
      return false;
    } else {
      return true;
    }
  }

  void validatePhoneNumber(String phoneNumber) {
    if (isValidPhoneNumber(phoneNumber)) {
      _validationResult = 'Valid Phone Number';
    } else {
      _validationResult = 'Invalid Phone Number';
    }

    // Notify listeners to update the UI
    notifyListeners();
  }


}
