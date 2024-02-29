import 'dart:developer';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:country_codes/country_codes.dart';
import 'package:country_picker/country_picker.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/login/login_screen.dart';
import 'package:date_madly_app/pages/login/otp_verification_screen.dart';
import 'package:date_madly_app/pages/login/phone_auth/phone_auth_screen.dart';
import 'package:date_madly_app/pages/login/signup/signup_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../network/api.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/signinButton/button_list.dart';
import '../../utils/signinButton/button_view.dart';
import '../../utils/texts.dart';
import '../../utils/user_text_field.dart';
import '../home/main.dart';
import 'gender.dart';
import 'verify_otp.dart';

class PhoneOTP extends StatefulWidget {
  const PhoneOTP({super.key});

  @override
  State<PhoneOTP> createState() => _PhoneOTPState();
}

class _PhoneOTPState extends State<PhoneOTP> {
  final controller = TextEditingController();
  final codeController = TextEditingController();

  String selectedCountryCode = '';
  late final CountryDetails? details;
  late final Locale locale;
  late ConfettiController _centerController;
  Api api = Api();
  late SharedPreferences sharedPreferences;
  bool phoneSignIn = false;

  @override
  void initState() {
    super.initState();
    details = CountryCodes.detailsForLocale();
    locale = CountryCodes.getDeviceLocale()!;
    codeController.text = "🇮🇳  +91";
    selectedCountryCode = "+91";
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
    _centerController.play();
    // print(details!.dialCode);
  }

  showSnackBar(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          elevation: 2.0),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }

  // verifyPhone(BuildContext context) {
  //   try {
  //     Provider.of<AuthProvider>(context, listen: false)
  //         .verifyPhone(selectedCountryCode,
  //             selectedCountryCode + controller.text.toString())
  //         .then((value) {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => VerifyOTP(
  //                   selectedCountryCode + controller.text.toString())));
  //     }).catchError((e) {
  //       String errorMsg = 'Cant Authenticate you, Try Again Later';
  //       if (e.toString().contains(
  //           'We have blocked all requests from this device due to unusual activity. Try again later.')) {
  //         errorMsg = 'Please wait as you have used limited number request';
  //       }
  //       _showErrorDialog(context, errorMsg);
  //     });
  //   } catch (e) {
  //     _showErrorDialog(context, e.toString());
  //   }
  // }

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
          selectedCountryCode = "+${country.phoneCode}";
          print(selectedCountryCode);
        }
        // print(country.flagEmoji),
        );
  }

  Future signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      var token = await FirebaseMessaging.instance.getToken();
      var params = {
        "name": userData['name'],
        "email": userData['email'],
        "device_tokens": token ?? "",
        "type": "email"
      };

      print(params);
      await sendToServer(context, params, userData['name'], userData['email']);
    } else {
      print(result.status);
      print(result.message);
    }
  }

  GoogleSignInAccount? _googleUser;

  /*Future _signInGoogle(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          ///TODO: put scopes app will use
        ],
      );

      /// if previously signed in, it will signin silently
      /// if not, the signin dialog/login page will pop up
      _googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
      // _googleUser = await googleSignIn
      //     .signInSilently(suppressErrors: false)
      //     .catchError((dynamic error) async {
      //   _googleUser = await googleSignIn.signIn();
      var token = await FirebaseMessaging.instance.getToken();
      print('************************${FirebaseMessaging.instance.getToken()}');
      // print("USer ${_googleUser!}");
      var params = {
        "name": _googleUser!.displayName,
        "email": _googleUser!.email,
        "device_tokens": token ?? "",
        "type": "email"
      };

      print(params);
      await sendToServer(
          context, params, _googleUser!.displayName, _googleUser!.email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }*/

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        // Obtain the auth details from the Google Sign-In
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,

          // PrefService.setValue('idToken', googleSignInAuthentication.accessToken);
        );
        // final GoogleSignInAuthentication googleSignInAuthentication =
        // await googleSignInAccount.authentication;
        final String accessToken = googleSignInAuthentication.accessToken ?? '';
        final String idToken = googleSignInAuthentication.idToken ?? '';
        final String email = googleSignInAccount.email ?? '';

        // Store idToken and email using SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('email', email);

        await FirebaseAuth.instance.signInWithCredential(credential);
        print('User signed in with Google successfully!');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeMain()));
      } else {
        print('Google Sign-In cancelled.');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> sendToServer(context, params, name, email) async {
    sharedPreferences = await SharedPreferences.getInstance();

    //UserModel profile = await api.user(Api.userExistsURL, params, "");

    sharedPreferences.setBool('login', true);

    sharedPreferences.setString("email", email);

    // if (profile.user!.name! == 'User Exists') {
    //   sharedPreferences.setBool("profileCompleted", true);
    //   sharedPreferences.setString("id", profile.user!.sId!);
    //   sharedPreferences.setString("gender", profile.user!.gender!);
    //   sharedPreferences.setString("jwtToken", profile.user!.jwtToken!);
    //   // print("Token ${profile.user!.jwtToken}");
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (c) => const HomeMain()));
    //   // print(profile.user!);
    // } else {
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const Gender()));
    // }
  }

  @override
  void dispose() {
    // dispose the controller
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,

      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              const SizedBox(
                width: 41,
              ),
              Image.asset(
                "assets/logos/logoSplashFill.png",
                scale: 3,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                Strings.Lovecirc,
                style: mulishbold.copyWith(fontSize: 15,color: ColorRes.darkGrey)
              ),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset(
            AssertRe.loginIntro,fit: BoxFit.cover,
            // "assets/images/loginIntro.png",
            scale: 3.3,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffFDEDF0),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => OtpVerificationSCreen(
                  //             phone: '',
                  //           ),
                  //         ));
                  //   },
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => OtpVerificationSCreen(
                  //               phone: '',
                  //             ),
                  //           ));
                  //     },
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
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
                      child: Text(
                        Strings.sign_up,
                        style: popinsbold().copyWith(color: ColorRes.white,fontSize: 14),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),

                  //   // Container(
                  //   //   height: 47,
                  //   //   width: MediaQuery.of(context).size.width * 0.7,
                  //   //   decoration: BoxDecoration(
                  //   //     boxShadow: [
                  //   //       BoxShadow(
                  //   //           color: Colors.grey.withOpacity(0.2),
                  //   //           spreadRadius: 2,
                  //   //           blurRadius: 5,
                  //   //           offset: Offset(2, 2)),
                  //   //     ],
                  //   //     borderRadius: BorderRadius.circular(
                  //   //       5,
                  //   //     ),
                  //   //     color: ColorRes.appColor,
                  //   //   ),
                  //   //   child: Row(
                  //   //     children: [
                  //   //       SizedBox(
                  //   //         width: 10,
                  //   //       ),
                  //   //       GestureDetector(
                  //   //         child: Container(
                  //   //           height: 30,
                  //   //           width: 30,
                  //   //           decoration: BoxDecoration(
                  //   //             color: Colors.white,
                  //   //             borderRadius: BorderRadius.circular(5),
                  //   //           ),
                  //   //           child: Image.asset(
                  //   //             'assets/icons/google.png',
                  //   //             scale: 4,
                  //   //           ),
                  //   //         ),
                  //   //       ),
                  //   //       SizedBox(
                  //   //         width: 10,
                  //   //       ),
                  //   //       Text('Continue With google',
                  //   //           style: TextStyle(
                  //   //               fontFamily: 'Poppins',
                  //   //               fontSize: 12,
                  //   //               color: ColorRes.white,
                  //   //               fontWeight: FontWeight.w900)),
                  //   //       SizedBox(
                  //   //         width: 20,
                  //   //       )
                  //   //     ],
                  //   //   ),
                  //   // ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   height: 47,
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.grey.withOpacity(0.2),
                  //           spreadRadius: 2,
                  //           blurRadius: 5,
                  //           offset: Offset(2, 2)),
                  //     ],
                  //     borderRadius: BorderRadius.circular(
                  //       5,
                  //     ),
                  //     color: Colors.white,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Image.asset(
                  //         'assets/icons/facebook.png',
                  //         scale: 4,
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text('Continue With Facebook',
                  //           style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               fontSize: 12,
                  //               color: ColorRes.appColor,
                  //               fontWeight: FontWeight.w900)),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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
                      child: Text(
                        Strings.log_in,
                        style: popinsbold().copyWith(color: ColorRes.white,fontSize: 14),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //               LoginScreen(), //LoginScreen()//
                  //         ));
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Don't have account ?",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           color: ColorRes.darkGrey,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //       Text(
                  //         ' Sign Up',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           color: ColorRes.appColor,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w600,
                  //           fontFamily: 'mulishBold',
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
