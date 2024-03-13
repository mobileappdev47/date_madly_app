import 'package:country_picker/country_picker.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/login/otp_verification_screen.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/user_text_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final codeController = TextEditingController();
  final phoneController = TextEditingController();
  String countryCode = '';
  String phone = '';
  String countryCodeError = '';
  String phoneError = '';

  String _validationResult = '';

  String get validationResult => _validationResult;

  bool isValidPhoneNumber(String phoneNumber) {
    // Add your phone number validation logic here
    // For simplicity, let's check if the length is 10
    return phoneNumber.length == 10;
  }

/*  void validatePhoneNumber(String phoneNumber) {
    if (isValidPhoneNumber(phoneNumber)) {
      _validationResult = 'Valid Phone Number';
    } else {
      _validationResult = 'Invalid Phone Number';
    }

    // Notify listeners to update the UI
    notifyListeners();
  }*/

  bool countryValidation() {
    if (codeController.text.trim() == "") {
      setState(() {
        countryCodeError = 'Select the your Country Code';
      });
      return false;
    } else {
      setState(() {
        countryCodeError = '';
      });
      return true;
    }
  }

  phoneValidation() {
    if (phoneController.text.trim() == '') {
      setState(() {
        phoneError = 'Enter the Mobile Number';
      });
      return false;
    } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
        .hasMatch(phoneController.text)) {
      setState(() {
        phoneError = '';
      });
      // return true;
    } else {
      setState(() {
        phoneError = 'Enter the valid number';
      });

      return true;
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

  void selectCountry() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        // showWorldWide: true,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          // backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500,
          // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          codeController.text = "${country.flagEmoji}  +${country.phoneCode}";
          print(codeController.text);
          countryCode = "+${country.phoneCode}";
          print(countryCode);
        }
        // print(country.flagEmoji),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: ColorRes.grey,
                    size: 15,
                  ),
                  Spacer(),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/logos/logoSplashFill.png",
                    scale: 3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Lovecircle",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Text('Country',
                  style: TextStyle(color: ColorRes.darkGrey, fontSize: 12)),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorRes.grey),
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                child: TextField(
                  controller: codeController,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Image.asset(
                      'assets/icons/down_arrow.png',
                      scale: 3,
                    ),
                  ),

                  onTap: () {
                    selectCountry();
                  },
                  readOnly: true,
                  onChanged: ((value) => {print(value)}),
                ),
              ),
              // countryCodeError != false?
              //     Text(countryCodeError) ? SizedBox(),
              SizedBox(
                height: 30,
              ),
              Text('Number Phone',
                  style: TextStyle(color: ColorRes.darkGrey, fontSize: 12)),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorRes.grey),
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your number',
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Image.asset(
                        'assets/icons/Phone_icon@2x.png',
                        color: ColorRes.grey,
                        scale: 3,
                      ),
                    ),
                  ),

                  onTap: () {},
                  onChanged: ((value) => {print(value)}),
                ),
              ),

              phoneError != "" ? Text(phoneError) : SizedBox(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                        'We need your mobile number to get you signed in',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: ColorRes.darkGrey, fontSize: 12)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (validation()) {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OtpVerificationSCreen(
                        //         verificationId: ,
                        //           phone: phoneController.text),
                        //     ));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: ColorRes.appColor,
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Terms Of Use Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorRes.grey, fontSize: 12)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
