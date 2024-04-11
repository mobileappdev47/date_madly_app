import 'package:country_picker/country_picker.dart';
import 'package:date_madly_app/common/common_gradient_button.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/otp_verification_screen.dart';
import 'package:date_madly_app/pages/login/phone_auth/new_otp_screen.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMobileNumberScreen extends StatefulWidget {
  const NewMobileNumberScreen({super.key});

  @override
  State<NewMobileNumberScreen> createState() => _NewMobileNumberScreenState();
}

class _NewMobileNumberScreenState extends State<NewMobileNumberScreen> {
  String countryName = 'IN';
  String countryCode = '91';
  TextEditingController phoneController = TextEditingController();

  bool loader = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(
      {required String countryCode, required String phoneNumber}) async {
    loader = true;
    setState(() {});
    // auth.setSettings().setAppVerificationDisabledForTesting(true);
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

        print("Phone verification failed--${e.toString()}");
        loader = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Phone verification failed',
              style: TextStyle(
                color: ColorRes.white,
              ),
            )));

      },
      codeSent: (String verificationId, int? resendToken) async {
        // TODO: Navigate to the screen where the user can enter the OTP
        loader = false;
        setState(() {});
        print("Otp sent successfully");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOtpScreen(
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'My number is',
                        style: interBold.copyWith(fontSize: 38, color: Colors.black),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            countryListTheme: CountryListThemeData(
                                              flagSize: 25,
                                              backgroundColor: Colors.white,
                                              textStyle: TextStyle(
                                                  fontSize: 16, color: Colors.blueGrey),
                                              bottomSheetHeight: 500,
                                              // Optional. Country list modal height
                                              //Optional. Sets the border radius for the bottomsheet.
                                              borderRadius: BorderRadius.only(
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
                                                    color: const Color(0xFF8C98A8)
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onSelect: (Country country) {
                                              setState(() {
                                                countryName = country.countryCode;
                                                countryCode = '${country.phoneCode}';
                                                print(
                                                    'Select country: ${country.displayName}');
                                              });
                                            },
                                          );
                                        },
                                        child: Text(
                                          '${countryName} +${countryCode}',
                                          style: inter.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: ColorRes.color444142),
                                        )),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: ColorRes.color444142,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 2,
                                  color: ColorRes.color444142,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  style: inter.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: ColorRes.color444142),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    border: InputBorder.none,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: ColorRes.color444142,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        Strings.aText,
                        style: inter.copyWith(
                          fontSize: 13,
                          color: ColorRes.color828693,
                        ),
                      ),
                      SizedBox(
                        height: 37,
                      ),
                      CommonGradientButton(
                        ontap: () {
                          if (phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please enter mobile number',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            verifyPhoneNumber(countryCode: '+${countryCode}',phoneNumber: phoneController.text);
                          }
                        },
                      ),


                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.termsOf,
                      style: inter.copyWith(
                        fontSize: 11,
                        color: ColorRes.colorACACAC,
                      ),
                    ),

                  ],
                ),
            SizedBox(
            height: 20,
                  ),
              ],
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
