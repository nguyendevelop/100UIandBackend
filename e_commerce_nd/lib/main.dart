/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-07-06 21:02:16
 * @modify date 2023-07-06 21:02:16
 * @desc [E-Commerce App]
 */
import './screens/auth_ui/welcome/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "E-Commerce App",
      home: Welcome(),
    );
  }
}
