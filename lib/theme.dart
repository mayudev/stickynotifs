import 'package:flutter/material.dart';

ThemeData buildDarkTheme() {
  var base = ThemeData.dark();

  return base.copyWith(
      appBarTheme:
          AppBarTheme(color: Colors.blue[200], foregroundColor: Colors.black),
      colorScheme: ColorScheme.dark(
        primary: Colors.blue[200]!,
        secondary: Colors.blue[300]!,
        surface: Colors.blue,
        onSurface: Colors.white,
      ),
      toggleableActiveColor: Colors.blue[300]!,
      splashColor: Colors.black38,
      inputDecorationTheme: inputDecodarionTheme);
}

InputDecorationTheme inputDecodarionTheme = const InputDecorationTheme()
    .copyWith(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)));
