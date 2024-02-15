import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../network/api.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/user_text_field.dart';
import '../home/main.dart';
import 'gender.dart';

class VerifyOTP extends StatefulWidget {
  final String phone;

  const VerifyOTP(this.phone, {super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final controller = TextEditingController();
  late ConfettiController _centerController;
  Api api = Api();
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
    _centerController.play();
  }

  @override
  void dispose() {
    _centerController.dispose();
    super.dispose();
  }

  // Api api = Api();
  showSnackBar(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            msg,
            style: const TextStyle(
                // color: Colors.white,
                ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          elevation: 3.0),
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

  verifyOTP() {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyOTP(controller.text.toString())
          .then((_) async {
        sharedPreferences = await SharedPreferences.getInstance();

        final fcmToken = await FirebaseMessaging.instance.getToken();
        print('********************${FirebaseMessaging.instance.getToken()}');
        var params = {"phoneNo": widget.phone, "device_tokens": fcmToken, "type":"phone"};

        UserModel profile = await api.user(Api.userExistsURL, params, "");

        sharedPreferences.setBool('login', true);
        sharedPreferences.setString("phoneNo", widget.phone);

        if (profile.user!.name! == 'User Exists') {
          sharedPreferences.setBool("profileCompleted", true);
          sharedPreferences.setString("id", profile.user!.sId!);
          sharedPreferences.setString("gender", profile.user!.gender!);
          sharedPreferences.setString("jwtToken", profile.user!.jwtToken!);
          print("Token ${profile.user!.jwtToken}");
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => const HomeMain()));
          // print(profile.user!);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Gender()));
        }
      }).catchError((e) {
        print("error $e");
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("invalid-verification-code")) {
          errorMsg = "You have entered wrong OTP!";
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      // body: SingleChildScrollView(
      // reverse: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // const SizedBox(height: 30),
            Expanded(
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
            ),
            // const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 1.25,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Please Enter Code sent to your number',
                          style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(height: 15),
                    UserTextField(
                        titleLabel: 'Enter 6 digit Code',
                        maxLength: 6,
                        icon: Icons.dialpad,
                        controller: controller,
                        inputType: TextInputType.phone),
                    // const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.text.length < 6) {
                            showSnackBar("Invalid OTP", context);
                          } else {
                            verifyOTP();
                          }
                        },
                        style: Constants.tonalButton(context),
                        child: Text('Verify OTP'.toUpperCase())),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
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
