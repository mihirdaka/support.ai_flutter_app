import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.black,

    // Define the default font family.
    fontFamily: 'ProductSans',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 14.0, fontFamily: 'ProductSans', color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 20.0,
          fontFamily: 'ProductSans',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontSize: 16.0,
          fontFamily: 'ProductSans',
          color: Colors.white,
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontSize: 28.0,
          fontFamily: 'ProductSans',
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: 'ProductSans',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.black,

    // Define the default `ButtonTheme`
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    )
        // // buttonColor: _darkButtonPrimaryColor,
        // textTheme: ButtonTextTheme.primary,

        ),

    // primaryTextTheme: TextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black.withOpacity(0.2),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),

        // borderSide: const BorderSide,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 0.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.white

          // backgroundColor: _darkSecondaryColor,
          ),
    ),

    // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
