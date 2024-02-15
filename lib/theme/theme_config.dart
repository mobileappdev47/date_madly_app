import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = const Color(0xff1f1f1f);
  static Color lightAccent = const Color.fromARGB(255, 226, 210, 119);
  static MaterialColor materialColors = Colors.indigo;

  static Color darkAccent = const Color.fromARGB(255, 139, 114, 23);
  static Color lightBG = const Color.fromARGB(255, 146, 141, 141);
  static Color darkBG = const Color(0xff121212);

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: materialColors),
      // backgroundColor: lightBG,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightBG,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal))
      // appBarTheme: AppBarTheme(
      //   color: lightPrimary,
      //   elevation: 0.0,
      //   titleTextStyle: const TextStyle(
      //       color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
      //   // iconTheme: const IconThemeData(color: Colors.black),
      // ),
      // textTheme: const TextTheme(
      //     headline1: TextStyle(
      //         fontSize: 16,
      //         color: Colors.black,
      //         height: 1.2,
      //         fontWeight: FontWeight.w500,
      //         fontFamily: "Soleil"),
      //     caption: TextStyle(color: Colors.black45, fontSize: 12),
      //     bodyText1: TextStyle(
      //         fontSize: 16,
      //         height: 1.5,
      //         color: Colors.black87,
      //         fontWeight: FontWeight.normal))
      );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal)),
    // colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
    // primarySwatch: materialColors,
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: const Color.fromARGB(255, 140, 172, 75),
    //     brightness: Brightness.dark),
    brightness: Brightness.dark,
    // backgroundColor: darkBG,
    // primaryColor: materialColors,
    // scaffoldBackgroundColor: darkBG,
    // appBarTheme: AppBarTheme(
    //   color: darkPrimary,
    //   elevation: 0.0,
    //   titleTextStyle: const TextStyle(
    //       color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
    //   // iconTheme: const IconThemeData(color: Colors.white),
    // ),
    // textTheme: const TextTheme(
    //     displayLarge: TextStyle(
    //         fontSize: 16,
    //         color: Colors.black,
    //         height: 1.2,
    //         fontWeight: FontWeight.w500,
    //         fontFamily: "Soleil"),
    //     bodySmall: TextStyle(color: Colors.black38, fontSize: 10),
    //     bodyLarge: TextStyle(
    //         fontSize: 16,
    //         height: 1.5,
    //         color: Colors.black87,
    //         fontWeight: FontWeight.normal))
  );
}
