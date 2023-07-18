import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_nd/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/user_model.dart';

class AppProvider with ChangeNotifier {
  //$$$$$$Cart here
  final List<ProductModel> _cartProductList = [];

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  // List<ProductModel> get cartProductList {
  //   return [..._cartProductList];
  // }
  List<ProductModel> get getCartProductList => _cartProductList;

  //$$$$$$$Favorite here
  final List<ProductModel> _favoriteProductList = [];

  void addFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductList;

  //$$$$$$$$$$Acount here
  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  // void updateUserInfoFirebase(
  //     BuildContext context, UserModel userModel, File? file) async {
  //   if (file == null) {
  //     showLoaderDialog(context);

  //     _userModel = userModel;
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_userModel!.id)
  //         .set(_userModel!.toJson());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.of(context).pop();
  //   } else {
  //     showLoaderDialog(context);

  //     String imageUrl =
  //         await FirebaseFirestoreHelper.instance.uploadUserImage(file);
  //     _userModel = userModel.copyWith(image: imageUrl);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_userModel!.id)
  //         .set(_userModel!.toJson());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.of(context).pop();
  //   }
  //   showMessage("Successfully updated profile");

  //   notifyListeners();
  // }
}
