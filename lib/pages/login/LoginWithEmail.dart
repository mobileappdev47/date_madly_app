import 'package:date_madly_app/network/api.dart';
import 'package:date_madly_app/utils/constants.dart';
import 'package:date_madly_app/utils/signinButton/button_list.dart';
import 'package:date_madly_app/utils/signinButton/button_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithEmail extends StatefulWidget {
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  late SharedPreferences sharedPreferences;
  Api api = Api();

  var phoneEmail;
  var pass;

  @override
  void initState() {
    // Displays the dial code for PT, +351.
    super.initState();
  }

  GoogleSignInAccount? _googleUser;
  Future _signInGoogle(BuildContext context) async {
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
      // print("USer ${_googleUser!}");
      var params = {
        "displayName": _googleUser!.displayName,
        "email": _googleUser!.email,
        "device_tokens": token ?? "",
        "photoUrl": _googleUser!.photoUrl ?? ""
      };

      print(params);
      // await sendToServer(context, params, _googleUser!.displayName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> sendToServer(context, params, name) async {
  //   SignupModel signup = await api.signupAPI(Api.registrationURL, params, "");
  //   if (signup.user != null) {
  //     //  if (!mounted) return;
  //     sharedPreferences = await SharedPreferences.getInstance();
  //     sharedPreferences.setString('login', 'false');
  //     // sharedPreferences.setString('email', params.email);
  //     sharedPreferences.setString("userdata", json.encode(signup));
  //     print(json.decode(sharedPreferences.getString('userdata')!));
  //     // if (!context.mounted) return;

  //     if (signup.registered == true) {
  //       print("old user");
  //       //old user
  //       if (signup.phoneRegistered == true) {
  //         sharedPreferences.setString('phone', "true");
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (c) => const AllProfile()));
  //       } else {
  //         // send to phone verification
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (c) => AuthScreen()));
  //       }
  //       // Navigator.pushReplacement(
  //       //     context, MaterialPageRoute(builder: (c) => const ProfileFor()));
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //     behavior: SnackBarBehavior.floating,
  //       //     content: Text('Login Successful. Welcome! $name')));
  //     } else {
  //       // new user
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           behavior: SnackBarBehavior.floating,
  //           content: Text('Please verify your mobile number to continue')));
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (c) => AuthScreen()));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        // appBar: AppBar(title: Text("Login Screen")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_cbljw63n.json'),
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              Text("Welcome!", style: Constants.largeTextStyle(context)),
              Text("Find your Life Partner easily...",
                  style: Constants.normalTextStyle(context),
                  textAlign: TextAlign.center),
              Spacer(),
              // Spacer(),
              // TextFormField(
              //   initialValue: details!.dialCode,
              //   keyboardType: TextInputType.phone,
              //   inputFormatters: [DialCodeFormatter()],
              //   maxLength: 13,
              //   // maxLines2 5,
              //   decoration: Constants.deco("Registered Phone No", "Phone No"),
              //   onSaved: (cid) {
              //     phoneEmail = cid;
              //   },
              //   onChanged: (c) async {
              //     setState(() {});
              //     // Country result = await Navigator.push(context,
              //     //     MaterialPageRoute(builder: (context) => SelectCountry()));
              //     // print(result);
              //     // c = result.dialCode!;
              //     phoneEmail = c;
              //   },
              // ),
              // SizedBox(height: 5),
              // TextFormField(
              //   // maxLines: 5,
              //   decoration: Constants.deco("Password", "Password"),
              //   keyboardType: TextInputType.text,
              //   onSaved: (cid) {
              //     pass = cid;
              //   },
              //   onChanged: (c) {
              //     pass = c;
              //   },
              // ),
              // SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Login with OTP", style: Constants.textStyle(context)),
              //       Text("Forgot Password?",
              //           style: Constants.textStyle(context)),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20),
              SignInButton(Buttons.GoogleDark,
                  text: "Continue with Google",
                  onPressed: () => _signInGoogle(context)),
              SignInButton(
                Buttons.Email,
                onPressed: () {},
              ),
              // SignInButton(
              //   Buttons.Twitter,
              //   onPressed: () {},
              // ),
              SignInButton(
                Buttons.FacebookNew,
                text: "Continue with Facebook",
                onPressed: () {
                  // signInWithFacebook(context);
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     FocusScopeNode currentFocus = FocusScope.of(context);
              //     if (!currentFocus.hasPrimaryFocus) {
              //       currentFocus.unfocus();
              //     }
              //     if (phoneEmail.toString().length <= 10) {
              //       _flushBar("Invalid Contact Number");
              //     } else if (pass.toString().length <= 6) {
              //       _flushBar("Password must be more than 6 characters long");
              //     } else {
              //       print("Hello");
              //       // setState(() {
              //       //   _isLoading = true;
              //       // });
              //       // sendToServer(phoneNo.toString(), pass.toString());
              //     }
              //   },
              //   style: Constants.tonalButton(context),
              //   child: Text("Login".toUpperCase(),
              //       style: TextStyle(fontSize: 15, letterSpacing: 1)),
              // ),
              SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     FocusScopeNode currentFocus = FocusScope.of(context);
              //     if (!currentFocus.hasPrimaryFocus) {
              //       currentFocus.unfocus();
              //     }
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return SignUp();
              //         },
              //       ),
              //     );
              //   },
              //   style: Constants.tonalButton(context),
              //   child: Text("signup".toUpperCase(),
              //       style: TextStyle(fontSize: 15, letterSpacing: 1)),
              // ),
              // Lottie.asset('assets/lottie/profile_boy.json'),
              // Text(
              //   "This profile is for",
              //   style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              // ),
              // SizedBox(height: 15),
              // Wrap(
              //   children: List<Widget>.generate(
              //     Utils.profile.length,
              //     (int index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(left: 4, right: 4),
              //         child: ChoiceChip(
              //           label: Text(Utils.profile[index]),
              //           selected: _value == index,
              //           onSelected: (bool selected) {
              //             setState(() {
              //               _value = selected ? index : _value;
              //             });
              //           },
              //         ),
              //       );
              //     },
              //   ).toList(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
