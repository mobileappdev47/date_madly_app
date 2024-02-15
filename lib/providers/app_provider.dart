import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_config.dart';
import '../utils/custom_colors.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }

  ThemeData theme = ThemeConfig.lightTheme;
  Key? key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  // change the Theme in the provider and SharedPreferences
  void setTheme(value, c) async {
    theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  final _brandBlue = const Color.fromARGB(255, 47, 108, 179);
  CustomColors lightCustomColors =
      const CustomColors(danger: Color.fromARGB(255, 60, 147, 223));
  CustomColors darkCustomColors =
      const CustomColors(danger: Color.fromARGB(255, 18, 51, 103));
  late ColorScheme lightColorScheme;
  late ColorScheme darkColorScheme;

  setDynamicColor(
      ColorScheme? lightDynamic, ColorScheme? darkDynamic, context) {
    if (lightDynamic != null && darkDynamic != null) {
      // On Android S+ devices, use the provided dynamic color scheme.
      // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
      lightColorScheme = lightDynamic.harmonized();
      // (Optional) Customize the scheme as desired. For example, one might
      // want to use a brand color to override the dynamic [ColorScheme.secondary].
      lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);
      // (Optional) If applicable, harmonize custom colors.
      lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

      // Repeat for the dark color scheme.
      darkColorScheme = darkDynamic.harmonized();
      darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
      darkCustomColors = darkCustomColors.harmonized(darkColorScheme);
    } else {
      // Otherwise, use fallback schemes.
      lightColorScheme = ColorScheme.fromSeed(seedColor: _brandBlue);
      darkColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue, brightness: Brightness.dark);
    }
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString('theme') ?? 'light';

    if (r == 'light') {
      t = ThemeConfig.lightTheme;
      setTheme(ThemeConfig.lightTheme, 'light');
    } else {
      t = ThemeConfig.darkTheme;
      setTheme(ThemeConfig.darkTheme, 'dark');
    }
    return t;
  }
}
