import 'package:flutter/material.dart';

ThemeData buildDarkTheme() {
  var base = ThemeData.dark();

  return base.copyWith(
      appBarTheme:
          AppBarTheme(color: Colors.blue[200], foregroundColor: Colors.black),
      colorScheme: ColorScheme.dark(
        primary: Colors.blue[200]!,
        surface: Colors.blue,
        onSurface: Colors.black,
      ),
      inputDecorationTheme: inputDecodarionTheme);
}

InputDecorationTheme inputDecodarionTheme = const InputDecorationTheme()
    .copyWith(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)));
