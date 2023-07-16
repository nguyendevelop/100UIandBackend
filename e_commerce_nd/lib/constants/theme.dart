import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.red,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      minimumSize: Size(double.infinity, 60),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Colors.white,
  //   elevation: 0.0,
  //   iconTheme: IconThemeData(
  //     color: Colors.black,
  //   ),
  // ),
  canvasColor: Colors.red,
  primarySwatch: Colors.red,
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);
