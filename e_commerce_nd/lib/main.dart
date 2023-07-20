/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-07-06 21:02:16
 * @modify date 2023-07-06 21:02:16
 * @desc [E-Commerce App]
 */

import 'package:e_commerce_nd/helper/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_commerce_nd/firebase_options.dart';
import 'package:e_commerce_nd/provider/app_provider.dart';
import 'package:e_commerce_nd/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerce_nd/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import './screens/auth_ui/welcome/welcome.dart';
import 'package:flutter/material.dart';

import 'constants/theme.dart';

//#https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NVsXFA5xdkjE0gW7KtklaFwtljCCuKY9mbM4IpFVrfbU6gFoFCBLzG05FdKTuyLstafuTShrX6FGV9E9SPKc3c80060q5wex0";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: "E-Commerce App",
        debugShowCheckedModeBanner: false,
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
                return CustomBottomBar();
              }
              return Welcome();
            }),
      ),
    );
  }
}
