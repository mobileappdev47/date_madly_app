import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/text_style.dart';
import '../../../utils/texts.dart';

class HavingTroubleSignScreen extends StatelessWidget {
  final String supportEmail = 'fredrick@lovecirco.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
       title:  Text(
          Strings.contactUs,
          style:
          mulishbold.copyWith(
              color: ColorRes
                  .appColor,
              fontSize: 22),
        ),
        backgroundColor: ColorRes.white,
        leading: IconButton(color: ColorRes.appColor,iconSize: 20,onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Having trouble signing in or creating an account?',
                // style: TextStyle(fontSize: 20),
                style:
                mulishbold.copyWith(
                    color: ColorRes.black,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Contact Support: ',
                      style:
                      mulishbold.copyWith(
                          color: ColorRes.black,fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: supportEmail,
                      style:
                      mulishbold.copyWith(decoration: TextDecoration.underline,
                          color: ColorRes.appColor,fontSize: 22,fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchEmail();
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: 'subject=Sign In/Account Issue',
    );
    String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}