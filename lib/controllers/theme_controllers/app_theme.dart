// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    bottomAppBarColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blueGrey.shade200.withOpacity(0.2),
      hintStyle: const TextStyle(color: Color(0xFF030F23)),
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(style: BorderStyle.solid, color: Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF030F23),
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFF030F23),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: const Color(0xFF030F23),
    bottomAppBarColor: const Color(0xFF030F23),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F4F7).withOpacity(0.1),
      hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(style: BorderStyle.solid, color: Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Color(0xFF030F23),
      shadowColor: Colors.transparent,
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
