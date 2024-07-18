import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
          'Terms And Conditions',
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
            Text(
              '* Individual user terms ',
              style: TextStyle(fontSize: 20, color: ColorRes.appColor),
            ),
            SizedBox(height: 10,),
            Text(
              '1) Acceptance of Terms of Use Agreement',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'a)  This Agreement is an electronic contract that establishes the legally binding terms you must accept to use the Service. This Agreement includes the Company’s Privacy Policy and terms disclosed and agreed to by you if you purchase or accept additional features, products, or services we offer on the Service.\nb)  We may, at any time and for any reason make changes to this Agreement. We may do this for a variety of reasons including to reflect changes in or requirements of the law, new features, or changes in business practices. The most recent version of this Agreement will be posted on the Services under Settings and on Lovecirco.co.uk and you should regularly check for the most recent version. The most recent version is the version that applies. If the changes include material changes that affect your rights or obligations, we will notify you of the changes by reasonable means, which could include notification through the Services or via email. If you continue to use the Services after the changes become effective, then you shall be deemed to have accepted those changes. If you don’t agree to these changes, you must end your relationship with us by ceasing to use the Services and terminating your profile and subscription with Lovecirco Dating App.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '2) Eligibility',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'You must be at least 18 years of age to create an account on Lovecirco and use the Service. By creating an account and using the Service, you represent and warrant that you can form a binding contract with Lovecirco, you are not a person who is barred from using the Service under the laws of the United Kingdom or any other applicable jurisdiction–or face any other similar prohibition, and you will comply with this Agreement and all applicable laws and regulations.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '3) Creating an Account on Lovecirco',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'In order to use Lovecirco, you must have or create a Facebook account and sign in using your Facebook login. If you do so, you authorise us to access and use certain Facebook account information, including your public Facebook profile, email and personal information. For more information regarding the information we collect from you and how we use it, please consult our Privacy Policy.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '4) Terms for Lovecirco',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'a)  Our service allows users to meet other users using your geo location and Matchmaking, (our services providing relevant meeting point venue). In providing details in your ‘set up profile’ such as, photo, occupation, about me, you hereby declare all information is truthful. In the event that it is determined that any of the information you have provided is misleading or inaccurate, we reserve the right to terminate your account.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'b)  LoveCirco Dating App was established as a platform for people who are serious about meeting other people, and we do not support untrustworthy or fickle behaviour. As such, if you cancel or fail to turn up to a date on two or more occasions, your account will be partially blocked for a 24h period and no further dates can be arranged during this time. By using these Services, you understand and agree that ongoing offences could result in permanent baring of your Lovecirco account by the Company in its sole discretion. Upon such termination or suspension, you will not be entitled to any pro-rata refund of unused app purchases.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '5) Non-commercial Use by Users',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'The Service is for personal use only. Users may not use the Service or any content contained in the Service (including, but not limited to, content of other users, designs, text, graphics, images, video, logos, software, and computer code) in connection with any commercial endeavours, such as advertising or soliciting any user to buy or sell any products or services not offered by the Company. Users of the Service may not use any information obtained from the Service to contact, advertise to, solicit, or sell to any other user without his or her prior explicit consent. Organisations, companies, and/or businesses may not use the Service for any purpose except with Now’s express consent (such as for promoted profiles or other advertisements), which Lovecircomay provide or deny in its sole discretion. The Company may investigate and take any available legal action in response to illegal and/or unauthorised uses of the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '6) Account Security',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'a) You are responsible for maintaining the confidentiality of your Facebook login credentials or other login means that you use to sign up for Lovecirco, and you are solely responsible for all activities that occur under those credentials',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'b) You agree to immediately notify the Company of any disclosure or unauthorised use of your login credentials at privacyright@Lovecirco.com',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '7) Your Interactions, and personal safety with Other Users',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'a) You are solely responsible for your interactions with other users. You understand that the company currently does not conduct criminal background checks on its users. The company also does not verify the statements of its users. The company makes no representations or warranties as to the conduct of users or their compatibility with any current or future users. The company reserves the right to conduct any criminal background check or other screenings (such as sex offender register searches), at any time and using available public records to the extent permitted by law.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'b) The Company is not responsible for the conduct of any user. As noted in and without limiting Sections 16 and 18 below, in no event shall the Company, its affiliates or its partners be liable (directly or indirectly) for any losses or damages whatsoever, whether direct, indirect, general, special, compensatory, consequential, and/or incidental, arising out of or relating to the conduct of you or anyone else in connection with the use of the Service including, without limitation, death, bodily injury, emotional distress, and/or any other damages resulting from communications or meetings with other users or persons you meet through the Service. You agree to take all necessary precautions in all interactions with other users, particularly if you decide to communicate off the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '8) PURCHASES AND AUTOMATICALLY RENEWING SUBSCRIPTIONS'
                  .toLowerCase(),
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'You will have the opportunity to purchase subscription services from Lovecirco. If you purchase a subscription, it will automatically renew - and you will be charged - until you cancel.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Lovecirco may offer products and services for purchase through iTunes, Google Play, Lovecirco may also offer products and services for purchase via credit card or other payment processors on the Website or inside the App ("Internal Purchases"). If you purchase a subscription, it will automatically renew until you cancel,in accordance with the terms disclosed to you at the time of purchase, as further described below. If you cancel your subscription, you will continue to have access to your subscription benefits until the end of your subscription period, at which point it will expire',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Because our Services may be utilized without a subscription, cancelling your subscription does not remove your profile from our Services. If you wish to fully terminate your account, you must contact customer care to do so.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Lovecirco operates as a local business, and our pricing varies based on several factors. We frequently offer promotional rates - which can vary based on location, length of subscription, bundle size, past purchases, account activity and more. We also regularly test new features and payment options. If you do not timely cancel your subscription, your subscription will be renewed at the full price as indicated when the purchase was made, without any additional action by you, and you authorize us to charge your payment method for these amounts. To the extent permissible by law, we reserve the right, including without prior notice, to limit the available quantity of or discontinue making available any product, feature, service or other offering; to impose conditions on the honoring of any coupon, discount, offer or other promotion; to bar any user from making any transaction; and to refuse to provide any user with any product, service or other offering. ',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '8a.) INTERNAL PURCHASES AND SUBSCRIPTIONS'.toLowerCase(),
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'Internal Purchases, including subscriptions, are processed using the Payment Method you provide on the Website or App. Subscriptions automatically renew until you cancel.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "If you make an Internal Purchase, you agree to pay the prices displayed to you for the Services you've selected as well as any sales or similar taxes that may be imposed on your payments (and as may change from time to time), and you authorize Lovecirco to charge the payment method you provide (your Payment Method). Lovecirco may correct any billing errors or mistakes even if we have already requested or received payment. If you initiate a chargeback or otherwise reverse a payment made with your Payment Method, Lovecirco may terminate your account immediately in its sole discretion, on the basis that you have determined that you do not want a Lovecirco subscription. In the event that your chargeback or other payment reversal is overturned, please contact Customer Care",
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'If your Internal Purchase includes an automatically renewing subscription, your Payment Method will continue to be periodically charged for the subscription until you cancel. After your initial subscription commitment period, and again after any subsequent subscription period, your subscription will automatically continue for the price and time period you agreed to when subscribing, until you cancel',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'To cancel a subscription, visit the SUBSCRIPTION section on your App Store or Google Play Store Settings. If you cancel a subscription, you may continue to use the cancelled service until the end of your then-current subscription term. The subscription will not be renewed when your then-current term expires.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '8b). REFUNDS'.toLowerCase(),
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'Generally, all purchases are nonrefundable. Special terms for refunds apply in the EU, EEA, UK, Switzerland, Korea, and Israel. Special terms for refunds also apply in Arizona, California, Colorado, Connecticut, Illinois, Iowa, Minnesota, New York, North Carolina, Ohio, Rhode Island, and Wisconsin.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'For subscribers residing in the EU, EEA, UK, and Switzerland:',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'In accordance with local law, you are entitled to a full refund during the 14 days after the subscription begins. Please note that this 14-day period commences when the subscription starts.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '9) Content Posted by You in the Service'.toLowerCase(),
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'a) You are solely responsible for the content and information that you post, upload, publish, link to, transmit, record, display or otherwise make available (collectively, “post”) on the Service or transmit to other users. You may not post as part of the Service, or transmit to the Company or any other user (either on or off the Service), any offensive, inaccurate, incomplete, abusive, obscene, profane, threatening, intimidating, harassing, racially offensive, or illegal material, or any material that infringes or violates another person’s rights (including intellectual property rights, and rights of privacy and publicity). You represent and warrant that;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '(i) all information that you submit upon creation of your account, including information submitted from your Facebook account, is accurate and truthful and that you will promptly update any information provided by you that subsequently becomes inaccurate, incomplete, misleading or false',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '(ii) you have the right to post the Content on the Service and grant the licenses set forth below.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'b) You understand and agree that the Company may, but is not obligated to, monitor or review any Content you post as part of a Service. The Company may delete any Content, in whole or in part, that in the sole judgment of the Company violates this Agreement or may harm the reputation of the Service or the Company.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'c) By posting Content as part of the Service, you grant to Lovecirco a worldwide, transferable, sub-licensable, royalty-free, right and license to host, store, use, copy, display, reproduce, adapt, edit, publish, modify and distribute the Content. This license is for the limited purpose of operating, developing, providing, promoting, and improving the Service and researching and developing new ones.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'd)  In addition to the types of Content described in Section 9) a) above, the following is a partial list of the kind of Content that is prohibited in the Service. You may not post, upload, display or otherwise make available Content that promotes racism, bigotry, hatred or physical harm of any kind against any group or individual; advocates harassment or intimidation of another person; requests money from, or is intended to defraud, other users of the Service; spams or solicits Lovecirco’s users; promotes information that is false or misleading, or promotes illegal activities or conduct that is defamatory, libellous or otherwise objectionable; promotes an illegal or unauthorised copy of another person’s copyrighted work, such as providing pirated computer programs, images, audio or video files or links to them; contains video, audio photographs, or images of another person without his or her permission (or in the case of a minor, the minor’s legal guardian); contains restricted or password only access pages, or hidden pages or images (those not linked to or from another accessible page); provides material that exploits people in a sexual, violent or other illegal manner, or solicits personal information from anyone under the age of 18; provides instructional information about illegal activities such as making or buying illegal weapons or drugs, violating someone’s privacy, or providing, disseminating or creating computer viruses; contains viruses, time bombs, trojan horses, cancelbots, worms or other harmful, or disruptive codes, components or devices; impersonates, or otherwise misrepresents affiliation, connection or association with, any person or entity; provides information or data you do not have a right to make available under law or under contractual or fiduciary relationships (such as inside information, proprietary and confidential information); solicits passwords or personal identifying information for commercial or unlawful purposes from other users or disseminates another person’s personal information without his or her permission',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'e) The Company reserves the right, in its sole discretion, to investigate and take any legal action against anyone who violates this provision, including removing the offending communication from the Service and terminating or suspending the account of such violators.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'f) Your use of the Service, including all Content you post through the Service, must comply with all applicable laws and regulations. You agree that the Company may access, preserve, and disclose your account information and Content if required to do so by law or in a good faith belief that such access, preservation or disclosure is reasonably necessary, such as to:',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'i)  comply with legal process',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'ii)  enforce this Agreement;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'iii)  respond to claims that any Content violates the rights of third parties;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'iv)  respond to your requests for customer service or allow you to use the Service in the future;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'v)  protect the rights, property or personal safety of the Company or any other person.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'g) You agree that any Content you place on the Service may be viewed by other users and may be viewed by any person visiting or participating in the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),
            Text(
              '10) Prohibited Activities',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),
            Text(
              'The Company reserves the right to investigate, suspend and/or terminate your account if you have misused the Service or behaved in a way the Company regards as inappropriate or unlawful, including actions or communications the occur off the Service but involve users you meet through the Service. The following is a partial list of the type of actions that you may not engage in with respect to the Service. You will not;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'a)  impersonate any person or entity',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'b)  solicit money from any users.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'c)  post any Content that is prohibited by Section 8.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'd)  “stalk” or otherwise harass any person.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'e)  express or imply that any statements you make are endorsed by the Company without our specific prior written consent.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'f)  use the Service in an illegal manner or to commit an illegal act.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'g)  access the Service in a jurisdiction in which it is illegal or unauthorised;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'h)  use any robot, spider, site search/retrieval application, or other manual or automatic device or process to retrieve, index, “data mine”, or in any way reproduce or circumvent the navigational structure or presentation of the Service or its contents.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'i)  collect usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email or unauthorised framing of or linking to the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'j)  interfere with or disrupt the Service or the servers or networks connected to the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'k)  transmit any material that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'l)  forge headers or otherwise manipulate identifiers in order to disguise the origin of any information transmitted to or through the Service (either directly or indirectly through use of third party software).',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'm)  “frame” or “mirror” any part of the Service, without the Company’s prior written authorisation.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'n)  use meta tags or code or other devices containing any reference to the Company or the Service (or any trademark, trade name, service mark, logo or slogan of the Company) to direct any person to any other website for any purpose.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'o)  modify, adapt, sublicense, translate, sell, reverse engineer, decipher, decompile or otherwise disassemble any portion of the Service any software used on or for the Service, or cause others to do so.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'p)  post, use, transmit or distribute, directly or indirectly, (e.g. screen scrape) in any manner or media any content or information obtained from the Service other than solely in connection with your use of the Service in accordance with this Agreement.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10,),

            Text(
              '11) Customer Service',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),


            Text(
              'The Company provides assistance and guidance through its customer care representatives. When communicating with our customer care representatives, you agree to be respectful and kind. If we feel that your behaviour towards any of our customer care representatives or other employees is at any time threatening or offensive, we reserve the right to immediately terminate your account with no refund of any subscription or in app purchase fees.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '12) In App Purchases',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),
            Text(
              'If you choose to make an in app purchase, you will be prompted to enter details for your account with the mobile platform you are using (e.g., Apple, Android, etc.) (“your IAP Account”), and your IAP Account will be charged for the in app purchase in accordance with the terms disclosed to you at the time of purchase as well as the general terms for in app purchases that apply to your IAP Account. You will not be charged re-occurring payments. Please refer to the terms of your application platform which apply to yourin app purchases.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '13) Modifications to Service',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              'The Company reserves the right at any time to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. You agree that the Company shall not be liable to you or to any third party for any modification, suspension, or discontinuance of the Service. To protect the integrity of the Service, the Company reserves the right at any time in its sole discretion to block users from certain IP addresses from accessing the Service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '14) Proprietary Rights',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),



            Text(
              'The Company owns and retains all proprietary rights in the Service, and in all content, trademarks, trade names, service marks and other intellectual property rights related thereto. The Service contains the copyrighted material, trademarks, and other proprietary information of the Company and its licensors. You agree to not copy, modify, transmit, create any derivative works from, make use of, or reproduce in any way any copyrighted material, trademarks, trade names, service marks, or other intellectual property or proprietary information accessible through the Service, without first obtaining the prior written consent of the Company or, if such property is not owned by the Company, the owner of such intellectual property or proprietary rights. You agree to not remove, obscure, or otherwise alter any proprietary notices appearing on any content, including copyright, trademark and other intellectual property notices.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),       SizedBox(height: 10,),

            Text(
              '15) Copyright',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'a)  You may not post, distribute, or reproduce in any way any copyrighted material, trademarks, or other proprietary information without obtaining the prior written consent of the owner of such proprietary rights. If you believe that your work has been copied and posted on the Service in a way that constitutes copyright infringement, please provide LoveCirco Dating App with the following information:',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'i)  an electronic or physical signature of the person authorised to act on behalf of the owner of the copyright interest;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'ii)  a description of the copyrighted work that you claim has been infringed;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ), Text(
              'iii)  a description of where the material that you claim is infringing is located on the Service (and such description must be reasonably sufficient to enable the Company to find the alleged infringing material, such as a url);',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'iv)  your address, telephone number and email address',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'v)  a written statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; and',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'vi)  a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorised to act on the copyright owner’s behalf',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'b)  Notice of claims of copyright infringement should be provided to us at privacyright@lovecirco.com',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),

            Text(
              '16) Disclaimers',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),

            Text(
              'a) You acknowledge and agree that neither the Company nor its affiliates and third-party partners are responsible for and shall not have any liability, directly or indirectly, for any loss or damage, including personal injury or death, as a result of or alleged to be the result of;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'i)  any incorrect or inaccurate Content posted in the Service, whether caused by users or any of the equipment or programming associated with or utilized in the Service;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'ii)  the timeliness, deletion or removal, incorrect delivery, or failure to store any Content or communications;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'iii)  the conduct, whether online or offline, of any user;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'iv)  any error, omission or defect in, interruption, deletion, alteration, delay in operation or transmission, theft or destruction of, or unauthorised access to, any user or user communications;',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'v) Any problems, failure or technical malfunction of any telephone network or lines, computer online systems, servers or providers, computer equipment, software, failure of email or players on account of technical problems or traffic congestion on the Internet or at any website or combination thereof, including injury or damage to users or to any other person’s computer or device related to or resulting from participating or downloading materials in connection with the Internet and/or in connection with the Service',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'b) To the maximum extent allowed by applicable law, the company provides the service on an “as is” and “as available” basis and grants no warranties of any kind, whether express, implied, statutory or otherwise with respect to the service (including all content contained therein), including (without limitation) any implied warranties of satisfactory quality, merchantability, fitness for a particular purpose or non- infringement. The company does not represent or warrant that the service will be uninterrupted or error free, secure or that any defects or errors in the service will be corrected.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),Text(
              'c)  Any material downloaded or otherwise obtained through the use of the service is accessed at your own discretion and risk, and you will be solely responsible for and hereby waive any and all claims and causes of action with respect to any damage to your device, computer system, internet access, download or display device, or loss or corruption of data that results or may result from the download of any such material. If you do not accept this limitation of liability, you are not authorised to download or obtain any material through the service.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '17) Limitation on Liability',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),

            Text(
              'To the fullest extent allowed by applicable law, in no event will the company, its affiliates, business partners, licensors or service providers be liable to you or any third person for any indirect, reliance, consequential, exemplary, incidental, special or punitive damages, including, without limitation, loss of profits, loss of goodwill, damages for loss, corruption or breaches of data or programs, service interruptions and procurement of substitute services, even if the company has been advised of the possibility of such damages. Notwithstanding anything to the contrary contained herein, the company’s liability to you for any cause whatsoever, and regardless of the form of the action, will at all times be limited to the amount paid, if any, by you to the company for the service while you have an account.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),       SizedBox(height: 10,),
            Text(
              '18) Indemnity by You',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),


            Text(
              'You agree to indemnify and hold the Company, its subsidiaries, and affiliates, and its and their officers, agents, partners and employees, harmless from any loss, liability, claim, or demand, including reasonable attorney’s fees, made by any third party due to or arising out of your breach of or failure to comply with this Agreement (including any breach of your representations and warranties contained herein), any postings or Content you post in the Service, and the violation of any law or regulation by you. The Company reserves the right to assume the exclusive defence and control of any matter otherwise subject to indemnification by you, in which event you will fully cooperate with the Company in connection therewith',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '19) Notice',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 10,),
            Text(
              'The Company may provide you with notices, including those regarding changes to this Agreement, using any reasonable means, which may include email or postings in the Service. Such notices may not be received if you violate this Agreement by accessing the Service in an unauthorised manner. You agree that you are deemed to have received all notices that would have been delivered had you accessed the Service in an authorised manner.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '20) Entire Agreement',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),

            Text(
              'This Agreement, with the Privacy Policy and any specific guidelines or rules that are separately posted for particular services or offers in the Service, contains the entire agreement between you and the Company regarding the use of the Service. If any provision of this Agreement is held invalid, the remainder of this Agreement shall continue in full force and effect. The failure of the Company to exercise or enforce any right or provision of this Agreement shall not constitute a waiver of such right or provision. You agree that your Lovecircoaccount is non-transferable and all of your rights to your profile or contents within your Lovecircoaccount terminate upon your death. No agency, partnership, joint venture or employment is created as a result of this Agreement and you may not make any representations or bind the Company in any manner.',
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(
              '21) Applicable law',
              style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontWeight: FontWeight.w600),
            ),


            SizedBox(height: 10,),


            Text(
              'This Agreement, its subject matter and its formation, are governed by English law. You and we both agree to that the courts of England and Wales will have non-exclusive jurisdiction. However, if you are a resident of Northern Ireland you may also bring proceedings in Northern Ireland, and if you are resident of Scotland, you may also bring proceedings in Scotland.',
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
