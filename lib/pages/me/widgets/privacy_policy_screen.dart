import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: ColorRes.appColor,size: 18,)),
        centerTitle: true,
        backgroundColor: ColorRes.white,
        title: Text(
          'Privacy Policy',
          style: mulishbold.copyWith(
            fontSize: 18.75,
            color: ColorRes.appColor,
          ),
        ),


      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '* Lovecirco LTD Privacy agreement',
              style: TextStyle(fontSize: 20, color: ColorRes.appColor),
            ),
            SizedBox(height: 10,),


            Text(
              'LOVECIRCO LTD. (“Lovecirco”, “we”, and “us”) respects the privacy of its users (“you” “You’re”) and has developed this Privacy Policy to demonstrate its commitment to protecting your privacy.This Privacy Policy describes the information we collect, how that information may be used, with whom it may be shared, and your choices about such uses and disclosures. We encourage you to read this Privacy Policy carefully when using our application or services or transacting business with us. By using our website or application (our “Service”), you are accepting the practices described in this Privacy Policy. If you have any questions about our privacy practices, please refer to the end of this Privacy Policy for information on how to contact us.For the purpose of the Data Protection Act 1998 (the Act), the data controller is Lovecirco Limited of 15466823 the registrar of companies in England and Wales.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
              'Information we collect about you',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'In General, we may collect information that can identify you such as your name and email address (“personal information”) and other information that does not identify you. We may collect this information through a website or a mobile application. By using the Service, you are authorising us to gather, process and retain data related to the provision of the Service. When you provide personal information through our Service, the information may be sent to servers located in the United Kingdom and countries around the world.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'Information you provide',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'In order to register as a user with Lovecirco, you will be asked to sign in using your Facebook login, Apple or with Phone. If you do so, you authorise us to access certain Facebook account information, such as your public Facebook profile (consistent with your privacy settings in Facebook), your email address, interests, gender, birthday, current city, photos, personal description, friend list, and information about and photos of your Facebook friends who might be common Facebook friends with other Lovecirco users.\nYou will also be asked to allow Lovecirco to collect your location, meeting points, and other relevant information from your device when you download or use the Service. In addition, we may collect and store any personal information you provide while using our Service or in some other manner. This may include identifying information, such as your name, address, email address, if you transact business with us, financial information. You may also provide us photos, a personal description and information about your gender and preferences for recommendations, such as search distance, age range and gender.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'Use of technologies to collect information',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'We use various technologies to collect information from your device and about your activities on our Service.\nInformation collected automatically: We automatically collect information from your browser or device when you visit our Service. This information could include your IP address, device ID and type, your browser type and language, the operating system used by your device, access times, your mobile device’s geographic location while our application is actively running or if you are logged in.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),

            Text(
              'Cookies and Use of Cookie Data',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'When you visit our Service, we may assign your device one or more cookies to facilitate access to our Service and to personalise your experience.Mobile Device IDs: If you’re using our app, we use mobile device IDs (the unique identifier assigned to a device by the manufacturer). We do this to store your preferences and track your use of our app. Unlike cookies, device IDs cannot be deleted. Analytics companies use device IDs to track information about app usage.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
           'In General: We may use information that we collect about you to deliver and improve our products and services, and manage our business;',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),



            Text(
              'i) manage your account and provide you with customer support; perform research and analysis about your use of, or interest in, our or others’ products, services, or content;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'ii) carry out statistical analysis of locations, date meetings, first name, to assigned for your dates website or mobile application analytics;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'iii) verify your eligibility and deliver prizes in connection with contests and sweepstakes;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'iv) enforce or exercise any rights in our Terms of Use',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'v) perform functions or services as otherwise described to you at the time of collection.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
              'With whom we share your information',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),



            Text(
              'Information Shared with Other Users: When you register as a user of Lovecirco your Lovecirco profile will be viewable by other users of the Service. Other users (and in the case of any sharing features available on Lovecirco, the individuals or apps with whom a Lovecirco user may choose to share you with) will be able to view information you have provided to us directly or through Facebook, such as your Facebook photos, any additional photos you upload, your first name, your age, approximate number of miles away, your personal description, and information you have in common with the person viewing your profile. We may share information we collect, including your profile and personal information, number of arranged or previous date occurrences, and locations whilst using our service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),



            SizedBox(height: 10,),

            Text(
             'Other Situations',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'We may disclose your information, including personal information in the following circumstances:',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'i) response to a subpoena or similar investigative demand, a court order, or a request for cooperation from a law enforcement or other government agency;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'ii) to establish or exercise our legal rights in respect of, but not limited to, enforcing our Terms of Agreement and policies and procedures;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'iii) to defend against legal claims;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'iv) or as otherwise required by law;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'v) when we believe disclosure is appropriate in connection with efforts to investigate, prevent, or take other action regarding illegal activity, suspected fraud or other wrongdoing;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'vi) to protect and defend the rights, property or safety of our company, our users, our employees, or others members.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'vii) in connection with a substantial corporate transaction, such as the sale of our business, a divestiture, merger, consolidation, or asset sale, or in the unlikely event of bankruptcy.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'We may use and share non-personal information we collect under any of the above circumstances. We may also share it with our registered meeting points (date locations) We may combine non-personal information we collect with additional non-personal information collected from other sources. We also may share aggregated, non-personal information, or personal information in hashed, non-human readable form, with third parties, including advisors, advertisers and investors, for the purpose of conducting general business analysis or other business purposes.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
             'How you can access your information',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),



            Text(
              'If you have a Lovecirco account, you have the ability to review and update your personal information within the Service by opening your account and going to settings or edit profile. You also may close your account at any time by visiting the “Settings” page for your account and contacting support to let them know you want to deactivate your account. If you close your account, we will retain certain information associated with your account for analytical purposes and record keeping integrity, as well as to prevent fraud, enforce our Terms of Use, take actions we deem necessary to protect the integrity of our Service or our users, or take other actions otherwise permitted by law. In addition, if certain information has already been provided to third parties as described in this Privacy Policy, retention of that information will be subject to those third parties’ policies. Non personal data and information can be erased by supplying us with in order your Facebook id, name, age, date of register directly to privacy support in settings, with direct instructions on you wanting to do so, if not supplied in this matter, we will only remove your personal profile and information upon request.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'Your choices about collection and use of your information',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'You can choose not to provide us with certain information, but that may result in you being unable to use certain features of our Service because such information may be required in order for you to register as user; purchase products or services; promotion, survey, or sweepstakes; ask a question; or initiate other transactions. Our Service may also deliver notifications to your phone or mobile device. You can disable these notifications by going into settings on your mobile device. You can also control information collected by cookies. You can delete or decline cookies by changing your browser settings. Click “help” in the toolbar of most browsers for instructions',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
              'How we protect your personal information',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'We take the security of your data very seriously and have security measures to help safeguard your personal information from unauthorised access and disclosure. Unfortunately, the transmission of information via the internet is not completely secure. Although we will do our best to protect your personal data, we cannot guarantee the security of your data transmitted to our site; any transmission is at your own risk. Once we have received your information, we will use strict procedures and security features to try to prevent unauthorised access. We provide areas on our Service where you can post information about yourself on your profile information. Such postings are governed by our Terms of Use. Also, whenever you voluntarily disclose personal information on publicly-viewable pages, that information will be publicly available and can be collected and used by others. For example, if you share your email address with other users on Lovecirco, you may receive unsolicited messages. We cannot control what other users may do with the information you voluntarily share, so we encourage you to exercise discretion and caution with respect to your personal information',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
              'Children’s privacy',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'Although our Service is a general audience Service, we restrict the use of our service to individuals aged 18 and below. We do not knowingly collect, maintain, or use personal information from children under the age of 18, and any user under the age of 18 is acting in contravention of our Terms of Use.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'Visiting our Service from outside the United Kingdom',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),


            Text(
              'If you are visiting our Service from outside the United Kingdom, please be aware that your information may be transferred to, stored, and processed with Amazon AWS server, security, and protection. By using our services, you understand and agree that your information may be transferred to our facilities and those third parties with whom we share it as described in this privacy policy.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'No Rights of Third Parties',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),


            Text(
              'This Privacy Policy does not create rights enforceable by third parties or require disclosure of any personal information relating to users of the website.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),


            SizedBox(height: 10,),

            Text(
              'Changes to this Privacy Policy',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'We will occasionally update this Privacy Policy to reflect changes in the law, our data collection and use practices, the features of our Service, or advances in technology. When we post changes to this Privacy Policy, we will revise the “last updated” date at the top of this Privacy Policy, which will be posted on the Services under “Settings” and on Lovecirco.com and you should regularly check for the most recent version, which is the version that applies. If we make any material changes to this Privacy Policy, we will notify you of the changes by reasonable means, which could include notifications through the Services or via email. Please review the changes carefully. Your continued use of the Services following the posting of changes to this policy will mean you consent to and accept those changes. If you do not consent to such changes, you can delete your account by following the instructions under Settings.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              'How to contact us',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),


            Text(
              'If you have any questions about this Privacy Policy, please contact us app in ‘settings’ or by email as follows: privacyright@lovecirco.com',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20,),



          ],
        ),
      ),
    );
  }
}
