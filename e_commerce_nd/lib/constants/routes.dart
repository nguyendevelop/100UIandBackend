import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();

  Future<dynamic> pushAndRemoveUntil(
      {required widget,
      required BuildContext context,
      String? routeNameToKeep}) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => widget),
      ModalRoute.withName(routeNameToKeep!),
    );
  }

  Future<dynamic> push({required widget, required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }
}
