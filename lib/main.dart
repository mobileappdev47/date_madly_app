import 'dart:async';
import 'dart:io';

import 'package:country_codes/country_codes.dart';

import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/pages/chat/main.dart';
import 'package:date_madly_app/pages/home/home.dart';
import 'package:date_madly_app/pages/home/likes_you_screen.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/login/dob.dart';
import 'package:date_madly_app/pages/login/gender.dart';
import 'package:date_madly_app/pages/login/Login_with_phone.dart';
import 'package:date_madly_app/pages/login/login/login_provider.dart';
import 'package:date_madly_app/pages/login/otp_verification_screen.dart';
import 'package:date_madly_app/pages/login/phone_auth/phone_auth_provider.dart';
import 'package:date_madly_app/pages/login/phone_auth/phone_auth_screen.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/pages/login/relationship_status.dart';
import 'package:date_madly_app/pages/login/signup/signup_provider.dart';
import 'package:date_madly_app/pages/login/signup/signup_screen.dart';
import 'package:date_madly_app/pages/login/tall.dart';
import 'package:date_madly_app/pages/login/work.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/pages/me/my_gallery.dart';
import 'package:date_madly_app/pages/me/widgets/ChangePassword/change_password.dart';
import 'package:date_madly_app/pages/me/widgets/ChangePassword/changepassword_provider.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/personal_data_provider.dart';
import 'package:date_madly_app/providers/auth_provider.dart';
import 'package:date_madly_app/providers/chat_provider.dart';
import 'package:date_madly_app/providers/city_provider.dart';
import 'package:date_madly_app/providers/countries_provider.dart';
import 'package:date_madly_app/providers/edit_profile_provider.dart';
import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:date_madly_app/providers/likes_provider.dart';
import 'package:date_madly_app/providers/upload_image_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/theme/theme_config.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/custom_colors.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:date_madly_app/utils/texts.dart';

// import 'package:date_madly_app/utils/mqtt_client.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/text_style.dart';
import 'providers/app_provider.dart';
import 'utils/firebase_options.dart';

// import 'package:web_socket_channel/status.dart' as status;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  // await Firebase.initializeApp();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDwNwwGJ772nIN8vUZJ9dLXRCmJeLd07tw",
        appId: "1:17736339925:ios:b2577bcc864240af5c2d5c",
        messagingSenderId: "17736339925",
        projectId: "datemadly-aec15",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAzFaniMZ-QFA4MUxL6DpurHyvxhsuGxXo",
        appId: "1:914912403564:android:180fc7869cad551620f849",
        messagingSenderId: "914912403564",
        projectId: "love-circo",
        storageBucket: 'love-circo.appspot.com',
      ),
    );
  }
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CountryCodes.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  // await initializeService();
  // FlutterBackgroundService().invoke("setAsBackground");
  // mqttFunctions.startMQTT();
  // var data = channel.stream;
  // print(data);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => SignUpProvider()),
    ChangeNotifierProvider(create: (_) => CountryProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CityProvider()),
    ChangeNotifierProvider(create: (_) => HomeMainProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => LikesProvider()),
    ChangeNotifierProvider(create: (_) => EditProfileProvider()),
    ChangeNotifierProvider(create: (_) => UploadImageProvider()),
    ChangeNotifierProvider(create: (_) => UploadImageProvider()),
    ChangeNotifierProvider(create: (_) => Updateprovider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => NewChatProvider()),
    ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder:
        (BuildContext context, AppProvider appProvider, Widget? child) {
      return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
        appProvider.setDynamicColor(lightDynamic, darkDynamic, context);
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: 'Lovecirco',
          theme: themeData(appProvider.theme, appProvider.lightColorScheme,
              appProvider.lightCustomColors),
          darkTheme: themeData(ThemeConfig.darkTheme,
              appProvider.darkColorScheme, appProvider.darkCustomColors),
          themeMode:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? ThemeMode.dark
                  : appProvider.theme == ThemeConfig.lightTheme
                      ? ThemeMode.light
                      : ThemeMode.dark,
          // home: phone! && profileCompleted!
          //     ? const HomeMain()
          //     : phone!
          //         ? const Gender()
          //         : const PhoneOTP());
          home: ChangeNotifierProvider(
            create: (context) => PhoneAuthProvider(),
            child: SplashScreen(),
          ),
        );
      });
    });
  }
}

// ChangeNotifierProvider(create: (_) => PhoneAuthProvider()),
class PreSplashScreen extends StatefulWidget {
  const PreSplashScreen({Key? key}) : super(key: key);

  @override
  State<PreSplashScreen> createState() => _PreSplashScreenState();
}

class _PreSplashScreenState extends State<PreSplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;
  bool? login = false;
  bool? profileCompleted = false;

  @override
  void initState() {
    super.initState();
    initSharedPreference();
  }

  initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (PrefService.getString(PrefKeys.userId) == '') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneOTP(),
          ));
    } else if (PrefService.getBool(PrefKeys.isAdditional) == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdditionalDetails(pageNo: 1),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeMain(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.white,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 1.5),
                Image.asset(
                  "assets/icons/logo.png",
                  scale: 2,
                ),
                Text(
                  "Lovecircl",
                  style: mulishbold.copyWith(
                      fontSize: 40, color: ColorRes.appColor),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 2.2),
                const CircularProgressIndicator(
                  color: ColorRes.appColor,
                ),
                Text(
                  Strings.Made,
                  style: mulishbold.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ));
  }
}

ThemeData themeData(
    ThemeData theme, ColorScheme colorScheme, CustomColors customColors) {
  return theme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(theme.textTheme),
      colorScheme: ColorScheme.fromSeed(seedColor: ColorRes.appColor),
      // extensions: [customColors],
      // sliderTheme:
      //     const SliderThemeData(showValueIndicator: ShowValueIndicator.never),
      pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }));
}
