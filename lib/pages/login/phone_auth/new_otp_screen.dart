import 'package:country_picker/country_picker.dart';
import 'package:date_madly_app/api/phone_otp_api.dart';
import 'package:date_madly_app/api/verify_otp_api.dart';
import 'package:date_madly_app/common/common_gradient_button.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/service/notification_service.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NewOtpScreen extends StatefulWidget {
  NewOtpScreen({super.key, required this.phone, required this.verificationId});

  final String phone;

  final String verificationId;

  @override
  State<NewOtpScreen> createState() => _NewOtpScreenState();
}

class _NewOtpScreenState extends State<NewOtpScreen> {
  TextEditingController otpController = TextEditingController();
  bool loader = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> body = {};
  Map<String, dynamic> body2 = {};

  phoneOtpAPi(body) async {
    try {
      await PhoneOtpApi.phoneOtp(body, context, lat, long);
    } catch (e) {
      print(e.toString());
    }
  }

  String lat = '';
  String long = '';

  Future getCurrentLatLang() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        getCurrentLatLang();
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = position.latitude.toString();
      long = position.longitude.toString();
    }
  }

  Future<void> verifyOTPFirebase() async {
    loader = true;

    setState(() {});
    String? token =
    await NotificationService.getToken();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );

      await auth.signInWithCredential(credential);
      body = {

        "phoneNo": "${widget.phone}",
        "device_token": token,
        "latitude": lat,
        "longitude": long

      };
      await phoneOtpAPi(body);
      loader = false;
      setState(() {});

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeMain(),
      //     ));
      print('Authentication successful');
    } catch (e) {
      loader = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Verification failed!'),
        backgroundColor: Colors.red,
      ));
      print('Verification failed: $e');
    }
  }

  Future<void>   verifyOtpApi() async {
    String? token =
    await NotificationService.getToken();

    body2 = {

      "phoneNo": "${widget.phone}",
      "otp": otpController.text,
      "device_token": token,
      "latitude": lat,
      "longitude": long

    };;
    try{
      loader = true ;
      setState(() {

      });
      await VerifyOtpApi.verifyOtpApi(body2, context, lat, long);
      loader = false ;
      setState(() {

      });
    }catch(e){
      loader = false ;
      setState(() {
      });
      print(e.toString());
    }

  }


  @override
  void initState() {

    getCurrentLatLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff828693),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'My code is',
                          style: interBold.copyWith(
                              fontSize: 38, color: Colors.black),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        PinCodeTextField(
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
                            errorBorderColor: ColorRes.color828693,
                            disabledColor: ColorRes.color828693,
                            inactiveFillColor: ColorRes.color828693,
                            inactiveColor: ColorRes.color828693,
                            selectedFillColor: ColorRes.color828693,
                            activeColor: ColorRes.color828693,
                            selectedColor: ColorRes.color828693,
                            shape: PinCodeFieldShape.underline,
                            activeBorderWidth: 1,
                            disabledBorderWidth: 1,
                            inactiveBorderWidth: 1,
                            selectedBorderWidth: 1,
                            borderWidth: 1,
                            errorBorderWidth: 1,
                            fieldHeight: 40,
                            fieldWidth: 40,
                            activeFillColor: Color(0xffACACAC),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        CommonGradientButton(
                          ontap: () async {
                            if (otpController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter otp!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (otpController.text.length != 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter valid otp!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              // await verifyOTPFirebase();

                              await verifyOtpApi();
                            }
                          },
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
