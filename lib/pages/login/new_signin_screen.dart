import 'package:date_madly_app/api/social_login_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/login/login_screen.dart';
import 'package:date_madly_app/pages/login/phone_auth/new_mobile_number_screen.dart';
import 'package:date_madly_app/pages/login/signup/signup_screen.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/service/notification_service.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../utils/texts.dart';

class NewSignInScreen extends StatefulWidget {
  const NewSignInScreen({super.key});

  @override
  State<NewSignInScreen> createState() => _NewSignInScreenState();
}

class _NewSignInScreenState extends State<NewSignInScreen> {
  bool loader = false ;
  Map<String,dynamic> body ={};
  String lat = '';
  String long = '';
   String token ='';

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

  socialLoginApi(body) async {
     token =
    (await NotificationService.getToken())!;
    try{
      loader = true ;
      setState(() {

      });

      await  SocialLoginApi.socialLogin(body, context, lat, long);

      loader= false ;
      setState(() {

      });

       }
        catch(e){
      print(e.toString());
loader= false ;
setState(() {

});
        }



  }

  onTapAppleSign({BuildContext? context, bool? value}) async {
    try {
      final user = await signInWithAppleSign(
          scopes: [Scope.email, Scope.fullName],
          context: context,
          value: value);

      debugPrint('uid: ${user.uid}');
      print("My user =====>>>> ${user.uid}");

      if(user!= null){
        print(user.email);
        print(FirebaseAuth.instance.currentUser?.email??'');
        body = {
          "email": "${user.email}",
          "device_token": token ?? '',
          "latitude": lat,
          "longitude": long
        };

       await  socialLoginApi(body);

        // Navigator.push(context!, MaterialPageRoute(builder: (context) => AdditionalDetails(pageNo: 1) ,));

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  signInWithAppleSign(
      {List<Scope> scopes = const [],
      BuildContext? context,
      bool? value}) async {
    // loader.value = true;
    final firebaseAuth = FirebaseAuth.instance;
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential!.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user;

         print(userCredential.user!.email);



        // loader.value = false;
        return firebaseUser;
      case AuthorizationStatus.error:
        // loader.value = false;
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        // loader.value = false;
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );

      default:
        // loader.value = false;
        throw UnimplementedError();
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
            fit: BoxFit.cover,
          )),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/new_logo.png",
                scale: 3,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  Strings.byCLick,
                  textAlign: TextAlign.center,
                  style: poppins.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.2,
                    fontFamily: Fonts.poppins,
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));

                        PrefService.setValue(PrefKeys.loginType, 'socialEmail');

                        onTapAppleSign(context: context,value: true,);
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(67),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Strings.signinwithapple.toUpperCase(),
                          style: poppins.copyWith(
                              fontSize: 14.5,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {

                        PrefService.setValue(PrefKeys.loginType, 'socialEmail');
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(67),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Strings.signinwithfb.toUpperCase(),
                          style: poppins.copyWith(
                              fontSize: 14.5,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {

                        PrefService.setValue(PrefKeys.loginType, 'Phone');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewMobileNumberScreen(),
                            ));
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(67),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Strings.signinwithphonenumber,
                          style: poppins.copyWith(
                              fontSize: 14.5,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.haveing,
                    style: poppins.copyWith(
                        fontSize: 14.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.poppins),
                  ),
                  /*GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: Text(
                      Strings.sign_up,
                      style: poppins.copyWith(
                          fontSize: 14.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: Fonts.poppins),
                    ),
                  ),*/
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
