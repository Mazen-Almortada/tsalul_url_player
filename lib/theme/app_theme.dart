import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color yellow = Color(0xFFFFE324);
  static const Color darkYellow = Color(0xFFFFB533);
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [yellow, darkYellow],
  );

  static const Color boldColorFont = Color(0xFF2A2E49);
  static const Color normalColorFont = Color(0xFFa2a1ae);

  static const Color scaffoldColor = Color(0xFFF5F6FA);

  static const Color redDarkPastel = Color(0xFFC23A22);

  static const TextStyle headline1 = TextStyle(
    fontSize: 26,
    color: boldColorFont,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 20,
    color: boldColorFont,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle text1 = TextStyle(
    fontSize: 18,
    color: normalColorFont,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle text2 = TextStyle(
    fontSize: 16,
    color: normalColorFont,
    fontWeight: FontWeight.w500,
  );
}
