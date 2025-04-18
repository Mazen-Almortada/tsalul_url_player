// import 'package:flutter/material.dart';

// class AppTheme {
//   AppTheme._();

//   static const Color boldColorFont = Color(0xFF2A2E49);
//   static const Color normalColorFont = Color(0xFFa2a1ae);

//   static const Color scaffoldColor = Color(0xFFF5F6FA);
//   static const Color whiteColor = Color.fromARGB(255, 246, 246, 250);

//   static const Color redDarkPastel = Color(0xFFC23A22);

//   static const TextStyle headline1 = TextStyle(
//     fontSize: 30,
//     color: whiteColor,
//     fontWeight: FontWeight.w700,
//     fontFamily: "PoppinsBold",
//   );

//   static const TextStyle headline2 = TextStyle(
//     fontSize: 20,
//     color: boldColorFont,
//     fontWeight: FontWeight.w700,
//   );

//   static const TextStyle text1 = TextStyle(
//     fontSize: 18,
//     color: normalColorFont,
//     fontWeight: FontWeight.w500,
//   );
//   static const TextStyle text2 = TextStyle(
//     fontSize: 16,
//     color: normalColorFont,
//     fontWeight: FontWeight.w500,
//   );
// }

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    primaryColor: Colors.amber,
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Color(0xFFF5F6FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkYellow,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[300],
      hintStyle: TextStyle(color: Colors.grey[700]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 130, 127, 127),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[800],
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static TextStyle get headlineStyle => const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle get headline2Style =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
  static TextStyle get titleStyle =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  static TextStyle get subtitleStyle =>
      const TextStyle(fontSize: 14, color: Colors.grey);

  static TextStyle darkSubtitleStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    color:
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[400]
            : Colors.grey,
  );
  //  static const TextStyle text1 = TextStyle(
  //     fontSize: 18,
  //     color: normalColorFont,
  //     fontWeight: FontWeight.w500,
  //   );
  static const Color redDarkPastel = Color(0xFFC23A22);

  static const Color yellow = Color(0xFFFFE324);
  static const Color darkYellow = Color(0xFFFFB533);
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [yellow, darkYellow],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color grayStart = Color(0xFF2E2E2E);
  static const Color grayEnd = Color(0xFF1C1C1C);

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [grayStart, grayEnd],
  );

  static const LinearGradient darkGrayGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 130, 127, 127),
      Color.fromARGB(255, 75, 75, 75),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.clamp,
  );
}
