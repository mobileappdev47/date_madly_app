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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorRes.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please enter the 4 digit OTP\nsent to +${widget.phone}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorRes.darkGrey,
                      fontSize: 14,
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
                  // animationDuration: Duration(seconds: 3),
                  //  enableActiveFill: true,
                  autoFocus: true,
                  obscureText: true,
                  obscuringWidget: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(color: Color(0xff5E5E5E),
                      borderRadius: BorderRadius.circular(30)
                    ),

                  ),
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
                    errorBorderColor: Color(0xffACACAC),
                    disabledColor: Color(0xffACACAC),
                    inactiveFillColor: Color(0xffACACAC),
                    inactiveColor: Color(0xffACACAC),
                    selectedFillColor: Color(0xffACACAC),
                    activeColor: Color(0xffACACAC),
                    selectedColor: Color(0xffACACAC),
                    shape: PinCodeFieldShape.box,
                    activeBorderWidth: 1,
                    disabledBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    selectedBorderWidth: 1,
                    borderWidth: 1,
                    errorBorderWidth: 1,
                    //shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 47,
                    fieldWidth: 47,
                    activeFillColor: Color(0xffACACAC),
                  ),
                ),
              ),

                SizedBox(
                height: 37,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Don't tell anyone the code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorRes.darkGrey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Expiring In 04 : 59",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorRes.darkGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'RESEND OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorRes.colorFF9BAD,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'mulishBold',
                ),
              ),
              SizedBox(
                height: 50,
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
                  child: Text('Accept',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              Spacer(),
              Text(
                'Terms Of Use Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorRes.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'mulishRegular',
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
