import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationSCreen extends StatefulWidget {
  OtpVerificationSCreen({Key? key, required this.phone, this.verificationId})
      : super(key: key);
  final String phone;
  final verificationId;
  @override
  State<OtpVerificationSCreen> createState() => _OtpVerificationSCreenState();
}

class _OtpVerificationSCreenState extends State<OtpVerificationSCreen> {
  TextEditingController pinPutController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool loader = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    loader = true;
    setState(() {});
    await auth.verifyPhoneNumber(
      phoneNumber: '$phoneNumber',
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
            backgroundColor: Colors.red,
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Otp sent successfully",
              style: TextStyle(
                color: ColorRes.white,
              ),
            )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        loader = false;
        setState(() {});
        print('koko');
      },
    );
  }

  Future<void> verifyOTP() async {
    loader = true;
    setState(() {});
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );

      await auth.signInWithCredential(credential);

      loader = false;
      setState(() {});
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeMain(),
          ));
      print('Authentication successful');
    } catch (e) {
      loader = false;
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Verification failed!')));
      print('Verification failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                        'OTP Verification',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: ColorRes.darkBlue,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'We’ve just send you 4 digits code to number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorRes.darkGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorRes.darkGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    // height: 50, width: 50, color: Colors.blueGrey,
                    child: PinCodeTextField(
                      showCursor: true,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      cursorColor: Color(0xffACACAC),
                      appContext: context,
                      length: 6,
                      onChanged: (value) {
                        // Handle changes in the entered pin code
                        print(value);
                      },
                      onCompleted: (value) {
                        // Handle when the user completes entering the pin code
                        print("Completed: $value");
                      },
                      pinTheme: PinTheme(
                        errorBorderColor: ColorRes.colorE5E5E5,
                        disabledColor: ColorRes.colorE5E5E5,
                        inactiveFillColor: ColorRes.colorE5E5E5,
                        inactiveColor: ColorRes.colorE5E5E5,
                        selectedFillColor: ColorRes.colorE5E5E5,
                        activeColor: ColorRes.colorE5E5E5,
                        selectedColor: ColorRes.colorE5E5E5,
                        shape: PinCodeFieldShape.underline,
                        activeBorderWidth: 1,
                        disabledBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        selectedBorderWidth: 1,
                        borderWidth: 1,
                        errorBorderWidth: 1,
                        fieldHeight: 47,
                        fieldWidth: 40,
                        activeFillColor: Color(0xffACACAC),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  GestureDetector(
                    onTap: () {
                      verifyOTP();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
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
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  GestureDetector(
                    onTap: () {
                      verifyPhoneNumber(phoneNumber: widget.phone);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn’t received the code?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorRes.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          ' Resend Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorRes.appColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'mulishBold',
                          ),
                        ),
                      ],
                    ),
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
