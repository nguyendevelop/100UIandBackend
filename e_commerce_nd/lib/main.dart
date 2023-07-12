/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-07-06 21:02:16
 * @modify date 2023-07-06 21:02:16
 * @desc [E-Commerce App]
 */

import 'package:e_commerce_nd/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_commerce_nd/firebase_options.dart';
import 'package:e_commerce_nd/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/auth_ui/welcome/welcome.dart';
import 'package:flutter/material.dart';

import 'constants/theme.dart';

//#https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-Commerce App",
      debugShowMaterialGrid: false,
      theme: lightTheme,
      // home: Welcome(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Welcome(),
      //   Login.routeName: (context) => Login(),
      //   SignUp.routeName: (context) => SignUp(),
      // },
      home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            }
            return const Welcome();
          }),
    );
  }
}
