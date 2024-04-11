import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/login/login_screen.dart';
import 'package:date_madly_app/pages/login/phone_auth/new_mobile_number_screen.dart';
import 'package:date_madly_app/pages/login/signup/signup_screen.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:flutter/material.dart';

import '../../utils/texts.dart';

class NewSignInScreen extends StatefulWidget {
  const NewSignInScreen({super.key});

  @override
  State<NewSignInScreen> createState() => _NewSignInScreenState();
}

class _NewSignInScreenState extends State<NewSignInScreen> {
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
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
                          Strings.sign_up.toUpperCase(),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

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
                          Strings.log_in.toUpperCase(),
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
              Text(
                Strings.haveing,
                style: poppins.copyWith(
                    fontSize: 14.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: Fonts.poppins),
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
