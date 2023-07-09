import 'package:e_commerce_nd/screens/auth_ui/login/login.dart';
import 'package:e_commerce_nd/screens/auth_ui/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();

  Future<dynamic> pushAndRemoveUntil(
      {required widget,
      required BuildContext context,
      String? routeNameToKeep}) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => widget),
      ModalRoute.withName('/'),
    );
  }

  Future<dynamic> push({required widget, required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
