import 'package:e_commerce_nd/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//#https://stackoverflow.com/questions/68269044/unable-to-catch-exception-in-flutter-thrown-during-the-firebase-email-sign-up-pr

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();
  //Đây là một getter (phương thức lấy giá trị) để truy cập vào Stream của authStateChanges
  //trong _auth. authStateChanges trả về một Stream lắng nghe sự thay đổi trạng thái xác thực
  //của người dùng. User là kiểu dữ liệu đại diện cho thông tin người dùng hiện tại.

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
}
