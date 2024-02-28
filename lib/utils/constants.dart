import 'package:flutter/material.dart';

class Constants {
  static ButtonStyle tonalButton(context) {
    ButtonStyle btn = ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            shape: const StadiumBorder(),

            // backgroundColor: const Color.fromARGB(255, 85, 172, 243),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 8,
                right: MediaQuery.of(context).size.width / 8,
                bottom: 14,
                top: 14))
        .copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
    return btn;
  }

  static var appName = 'Lovecirco';

  static ButtonStyle squareButton(context) {
    ButtonStyle btn = ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            // backgroundColor: const Color.fromARGB(255, 85, 172, 243),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 8,
                right: MediaQuery.of(context).size.width / 8,
                bottom: 14,
                top: 14))
        .copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
    return btn;
  }

  static ButtonStyle buttonWithoutColor(context) {
    ButtonStyle btn = ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            // backgroundColor: const Color.fromARGB(255, 85, 172, 243),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 8,
                right: MediaQuery.of(context).size.width / 8,
                bottom: 12,
                top: 12))
        .copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
    return btn;
  }

  static InputDecoration deco(t, l) {
    InputDecoration inputDecoration = InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      filled: true,

      // hintStyle: TextStyle(color: Colors.grey[600]),
      labelText: l,
      hintText: t,
    );
    return inputDecoration;
  }

  static TextStyle largeTextStyle(context) {
    TextStyle style = TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: 1);
    return style;
  }

  static TextStyle normalTextStyle(context) {
    TextStyle style = TextStyle(
      color: Theme.of(context).colorScheme.primary,
    );
    return style;
  }
}
