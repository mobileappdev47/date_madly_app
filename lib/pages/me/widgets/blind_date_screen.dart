import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BlindDateScreen extends StatelessWidget {
  const BlindDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorRes.appColor,
              size: 18,
            )),
        centerTitle: true,
        backgroundColor: ColorRes.white,
        title: Text(
          'Blind Date Service',
          style: mulishbold.copyWith(
            fontSize: 18.75,
            color: ColorRes.appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to our Blind Date Service, where we’re not just matchmakers, we’re dream weavers. In a world where finding meaningful connections can feel like searching for a needle in a haystack… we all deserve a chance at love.\n\n"
              "Navigating the world of dating can be tough, especially when you’re looking for something truly meaningful. Lovecirco blind date service is here to help you find that special someone who truly resonates with your heart and soul.\n\n"
              "Our approach is simple yet effective - we take the time to understand your preferences, interests, and values, and then we handpick potential matches who align with what you’re looking for. No more endless scrolling or wasted evenings on lackluster dates.\n\n"
              "Our dedicated team of matchmakers works tirelessly to ensure that each match is not only compatible but also has the potential for a meaningful connection. We believe that true love is out there for everyone, and we’re here to help you walk the path.\n\n"
              "Whether you’re new to the dating scene or a seasoned pro, our blind date service is here to make the process seamless, enjoyable, and most importantly, successful. Say goodbye to swiping fatigue and hello to a world of possibilities with us.\n\n"
              "So, what are you waiting for? Join us on this journey to find love, laughter, and a meaningful connection. Trust us to guide you on this exciting path towards your happily ever after. Let’s make magic happen together.\n\n",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'E-mail: ',
                    style:
                    mulishbold.copyWith(
                        color: ColorRes.black,fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: emailAddress,
                    style:
                    mulishbold.copyWith(decoration: TextDecoration.underline,
                        color: ColorRes.appColor,fontSize: 15,fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchEmail();
                      },
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _openWhatsApp,
              child: Container(
                height: 40.0,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(
                        0xffED1E79,
                      ),
                      Color(
                        0xffC1272D,
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Open WhatsApp to Connect',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWhatsApp() async {
    String phoneNumber = "447709978079";
    String message = Uri.encodeComponent(
        "Welcome aboard! Whether you’re seeking love, friendship, or meaningful connections, our premium service, Blind Date, is designed to enhance your experience. Feel free to explore and connect with like-minded individuals. If you have any questions or need assistance, just drop us a message. Happy dating!");

    String url = "https://wa.me/$phoneNumber?text=$message";

    // Launch the URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final String emailAddress = 'service.blinddate@lovecirco.com';

  void _launchEmail() async {
    String emailUrl = 'mailto:$emailAddress';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}
