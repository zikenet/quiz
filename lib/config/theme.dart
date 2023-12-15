//  textTheme: GoogleFonts.robotoTextTheme(),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Color(0XFF1C1C1C),
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  colorScheme: ColorScheme.dark(
    background: const Color(0XFF1C1C1C),
    primary: const Color(0XFF323232),
    primaryContainer: const Color(0XFF323232),
    // tertiary: Colors.white,
    tertiaryContainer: Colors.transparent,
    secondary: const Color(0XFF3EB8D4),
    shadow: Colors.grey.withOpacity(0.4),
    error: Colors.red,
    errorContainer: Colors.transparent,
    // secondary: Color(0XFF1C1C1C),
    // tertiary: Color(0XFF323232),
  ),
  // textTheme: GoogleFonts.robotoTextTheme(),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Color(0xFFFAFAFA),
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.light(
    background: const Color(0XFFFAFAFA),
    primary: Colors.white,
    primaryContainer: const Color(0XFFDCF8FF),
    // tertiary: Colors.black,
    tertiaryContainer: const Color(0XFF3EB8D4).withOpacity(0.1),
    secondary: const Color(0XFF3EB8D4),
    shadow: Colors.grey,
    error: Colors.red,
    errorContainer: Colors.red.withOpacity(0.1),
    // secondary: Colors.grey,
  ),
  // textTheme: GoogleFonts.robotoTextTheme(),
);

// dark - primary:  Color(0XFF323232)
// dark - primaryContainer:  Color(0XFFDCF8FF)
// dark - secondary: Color(0XFF3EB8D4),
// dark - shadow: Color(0XFF1C1C1C),
// white - primary = Colors.white,
// white - secondary: Color(0XFF3EB8D4),
// white - shadow: Colors.grey,
// white - error: Colors.red,
// white - errorContainer: Colors.red,
