import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationSCreen extends StatefulWidget {
  OtpVerificationSCreen({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  State<OtpVerificationSCreen> createState() => _OtpVerificationSCreenState();
}

class _OtpVerificationSCreenState extends State<OtpVerificationSCreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pinPutController = TextEditingController();
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
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
                  Text(
                    'Cancel',
                    style: TextStyle(color: ColorRes.appColor),
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
                    'We’ve just send you 4 digits code to your email',
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
                    'example@example.com',
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
                  length: 4,
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
                    fieldWidth: 60,
                    activeFillColor: Color(0xffACACAC),
                  ),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeMain(),
                      ));
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
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              SizedBox(
                height: 27,
              ),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
