import 'dart:developer';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:country_codes/country_codes.dart';
import 'package:country_picker/country_picker.dart';
import 'package:date_madly_app/pages/login/phone_auth/phone_auth_screen.dart';
import 'package:date_madly_app/pages/login/signup/signup_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/colors.dart';
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

  verifyPhone(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(selectedCountryCode,
              selectedCountryCode + controller.text.toString())
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyOTP(
                    selectedCountryCode + controller.text.toString())));
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
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

    UserModel profile = await api.user(Api.userExistsURL, params, "");

    sharedPreferences.setBool('login', true);

    sharedPreferences.setString("email", email);

    if (profile.user!.name! == 'User Exists') {
      sharedPreferences.setBool("profileCompleted", true);
      sharedPreferences.setString("id", profile.user!.sId!);
      sharedPreferences.setString("gender", profile.user!.gender!);
      sharedPreferences.setString("jwtToken", profile.user!.jwtToken!);
      // print("Token ${profile.user!.jwtToken}");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const HomeMain()));
      // print(profile.user!);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Gender()));
    }
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
      // body: SingleChildScrollView(
      // reverse: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
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
                        "LovecircO",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 40),
                  /* Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_XRMbLmFEl3.json'),
                    ConfettiWidget(
                      confettiController: _centerController,
                      createParticlePath: drawStar,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                        Colors.red,
                        Colors.lightGreen
                      ],
                      blastDirectionality: BlastDirectionality.explosive,
                      blastDirection: pi / 2,
                      maxBlastForce: 2,
                      minBlastForce: 1,
                      emissionFrequency: 0.03,
                      shouldLoop: true,
                      // 10 paticles will pop-up at a time
                      numberOfParticles: 5,
                      // particles will pop-up
                      gravity: 0,
                    ),
                  ],
                ),
              ),*/
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/loginIntro.png",
                    scale: 4,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.25,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Login / SignUp',
                              style: TextStyle(fontSize: 22))),
                      const SizedBox(height: 10),*/
                      //  Container(width: 240, child: LinearProgressIndicator()),
                      Visibility(
                        visible: phoneSignIn == false,
                        child: SignInButton(Buttons.GoogleDark,
                            text: "Continue with Google", onPressed: () {
                          signInWithGoogle();
                        }),
                      ),
                      // const SizedBox(height: 2),
                      // SignInButton(
                      //   Buttons.Email,
                      //   text: "Continue with Email",
                      //   onPressed: () {},
                      // ),
                      /* Visibility(
                          visible: phoneSignIn == false,
                          child: const SizedBox(height: 2)),
                      Visibility(
                        visible: phoneSignIn == false,
                        child: SignInButton(Buttons.FacebookNew,
                            text: "Continue with Facebook",
                            onPressed: () => signInWithFacebook(context)),
                      ),
                      const SizedBox(height: 10),*/
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 1.6,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(2, 2)),
                          ],
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'assets/icons/facebook.png',
                              scale: 4,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Continue With Facebook',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    color: ColorRes.appColor,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account ?",
                            style: TextStyle(
                              color: ColorRes.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
                                },
                                // builder: (c) => SignUpScreen()
                              ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: ColorRes.appColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* Visibility(
                          visible: phoneSignIn == false,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  phoneSignIn = true;
                                });
                              },
                              child: const Text("Continue with Phone Number",
                                  style: TextStyle(
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, -5),
                                            color: Colors.blue)
                                      ],
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                      decorationThickness: 5,
                                      decorationStyle:
                                          TextDecorationStyle.wavy)))),*/

                      // const Spacer(),

                      Visibility(
                        visible: phoneSignIn == true,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 22.0),
                                  child: TextField(
                                    controller: codeController,
                                    // keyboardType: TextInputType.phone,
                                    decoration: Constants.deco("", ""),
                                    onTap: () {
                                      selectCountry();
                                    },
                                    readOnly: true,
                                    onChanged: ((value) => {print(value)}),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: UserTextField(
                                  titleLabel: 'Enter your number',
                                  maxLength: 10,
                                  icon: Icons.smartphone,
                                  controller: controller,
                                  inputType: TextInputType.phone),
                            ),
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Visibility(
                        visible: phoneSignIn == true,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.text.length < 10) {
                                showSnackBar("Invalid Phone Number", context);
                              } else {
                                verifyPhone(context);
                              }
                            },
                            style: Constants.tonalButton(context),
                            child: Text('Send OTP'.toUpperCase())),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: phoneSignIn == true,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  phoneSignIn = false;
                                });
                              },
                              child: const Text("Back",
                                  style: TextStyle(
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, -5),
                                            color: Colors.blue)
                                      ],
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                      decorationThickness: 5,
                                      decorationStyle:
                                          TextDecorationStyle.wavy)))),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //  height: MediaQuery.of(context).size.height/2.5,
                  //  width: MediaQuery.of(context).size.width/1,
                  color: ColorRes.lightPink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Visibility(
                      //   visible: phoneSignIn == false,
                      //   child: SignInButton(
                      //
                      //       Buttons.FacebookNew,
                      //
                      //       text: "Continue with Google",
                      //       onPressed: () => _signInGoogle(context)),
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      /*GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>PhoneAuthScreen(),));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            color: ColorRes.appColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: (){
                                  signInWithGoogle;
                                },
                                child: Container(
                                  height: 30, width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorRes.white

                                  ),
                                  child: Image.asset(
                                    'assets/icons/google.png',
                                    scale: 3.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Continue With Google',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),*/
                      // const SizedBox(height: 2),
                      // SignInButton(
                      //   Buttons.Email,
                      //   text: "Continue with Email",
                      //   onPressed: () {},
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          visible: phoneSignIn == false,
                          child: const SizedBox(height: 2)),
                      /* Container(
                        height: MediaQuery.of(context).size.height/13,
                        decoration: BoxDecoration(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(2, 2)

                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 10,),
                            Image.asset(
                              'assets/icons/facebook.png',
                              scale: 4,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Continue With Facebook',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                    fontSize: 13,
                                    color: ColorRes.appColor,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(width: 20,)
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),*/

                      // Visibility(
                      //   visible: phoneSignIn == false,
                      //   child: SignInButton(Buttons.FacebookNew,
                      //       text: "Continue with Facebook",
                      //       onPressed: () => signInWithFacebook(context)),
                      // ),
                      const SizedBox(height: 10),
                      // Visibility(
                      //     visible: phoneSignIn == false,
                      //     child: GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             phoneSignIn = true;
                      //           });
                      //         },
                      //         child: const Text("Continue with Phone Number",
                      //             style: TextStyle(
                      //                 color: Colors.transparent,
                      //                 shadows: [
                      //                   Shadow(
                      //                       offset: Offset(0, -5),
                      //                       color: ColorRes.appColor)
                      //                 ],
                      //                 decoration: TextDecoration.underline,
                      //                 decorationColor: ColorRes.appColor,
                      //                 decorationThickness: 5,
                      //                 decorationStyle: TextDecorationStyle.wavy)))),

                      // const Spacer(),

                      /*   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account ?",style: TextStyle(
                            color: ColorRes.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
                                },
                                 // builder: (c) => SignUpScreen()
                              ));
                            },
                            child: Text("Sign Up",style: TextStyle(
                              color: ColorRes.appColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,

                            ),),
                          ),
                        ],
                      ),*/

                      // Visibility(
                      //   // visible: phoneSignIn == true,
                      //   visible: true,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 2,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(bottom: 22.0),
                      //             child: TextField(
                      //               controller: codeController,
                      //               // keyboardType: TextInputType.phone,
                      //               decoration: Constants.deco("", ""),
                      //               onTap: () {
                      //                 selectCountry();
                      //               },
                      //               readOnly: true,
                      //               onChanged: ((value) => {print(value)}),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 5,
                      //         child: UserTextField(
                      //             titleLabel: 'Enter your number',
                      //             maxLength: 10,
                      //             icon: Icons.smartphone,
                      //             controller: controller,
                      //             inputType: TextInputType.phone),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const Spacer(),
                      Visibility(
                        visible: phoneSignIn == true,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.text.length < 10) {
                                showSnackBar("Invalid Phone Number", context);
                              } else {
                                verifyPhone(context);
                              }
                            },
                            style: Constants.tonalButton(context),
                            child: Text('Send OTP'.toUpperCase())),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: phoneSignIn == true,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  phoneSignIn = false;
                                });
                              },
                              child: const Text("Back",
                                  style: TextStyle(
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, -5),
                                            color: ColorRes.appColor)
                                      ],
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorRes.appColor,
                                      decorationThickness: 5,
                                      decorationStyle:
                                          TextDecorationStyle.wavy)))),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
