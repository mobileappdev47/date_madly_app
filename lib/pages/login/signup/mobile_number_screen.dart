import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/otp_verification_screen.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:date_madly_app/utils/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  TextEditingController mobileController = TextEditingController();
  bool val() {
    mobileValidation();
    if (mobileError.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String mobileError = '';
  mobileValidation() {
    if (mobileController.text.trim() == "") {
      // setState(() {
      mobileError = 'Enter the mobile number';
      setState(() {});
      //  });
      return false;
    } else if (mobileController.text.length != 10) {
      mobileError = 'Please enter 10 character';
      setState(() {});
    } else {
      //  setState(() {
      mobileError = '';
      setState(() {});
      //  });
      return true;
    }
  }

  onTapNext() {
    if (val()) {
      verifyPhoneNumber(countryCode: '+91', phoneNumber: mobileController.text);
    }
  }

  bool loader = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(
      {required String countryCode, required String phoneNumber}) async {
    loader = true;
    setState(() {});
    await auth.verifyPhoneNumber(
      phoneNumber: '$countryCode$phoneNumber',
      timeout: const Duration(seconds: 10),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          if (userCredential.user != null) {
            // TODO: Navigate to the desired screen upon successful verification
            loader = false;
            setState(() {});
          }
        } catch (e) {
          loader = false;
          setState(() {});
          print("======================> ${e.toString()}");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone verification failed");
        loader = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Phone verification failed',
              style: TextStyle(
                color: ColorRes.white,
              ),
            )));
        setState(() {});
      },
      codeSent: (String verificationId, int? resendToken) async {
        // TODO: Navigate to the screen where the user can enter the OTP
        loader = false;
        setState(() {});
        print("Otp sent successfully");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationSCreen(
                  verificationId: verificationId,
                  phone: '$countryCode$phoneNumber'),
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        loader = false;
        setState(() {});
        print('koko');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mobile number',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: ColorRes.darkBlue,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: ColorRes.appColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorRes.colorE5E5E5,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorRes.colorE5E5E5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorRes.colorE5E5E5,
                        ),
                      ),
                      labelText: 'Mobile number',
                      labelStyle: greyText(),
                    ),
                  ),
                  mobileError.isNotEmpty
                      ? Text(
                          mobileError,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 13,
                    width: MediaQuery.of(context).size.width / 1,
                    child: CupertinoButton(
                        color: ColorRes.appColor,
                        child: Text(
                          'Next',
                          style: mulish14400.copyWith(
                              fontSize: 14,
                              color: ColorRes.white,
                              fontFamily: Fonts.poppinsBold),
                        ),
                        onPressed: () async {
                          onTapNext();
                        }),
                  ),
                ],
              ),
            ),
            loader == true
                ? Center(child: CircularProgressIndicator())
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
