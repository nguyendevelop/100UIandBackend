import 'package:e_commerce_nd/widgets/input_button/make_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          MakeInput(
            controllers: newpassword,
            labels: "Change Password",
            obscureTexts: isShowPassword,
            decorations: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                padding: EdgeInsets.zero,
                child: Icon(
                  isShowPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            keyboardTypes: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 24.0,
          ),
          MakeInput(
            controllers: confirmpassword,
            labels: "Confirm Password",
            obscureTexts: isShowPassword,
            decorations: InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                padding: EdgeInsets.zero,
                child: Icon(
                  isShowPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            keyboardTypes: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 36.0,
          ),
          ElevatedButton(
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("New Password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Confirm Password is empty");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Confrim Password is not match");
              }
            },
          ),
        ],
      ),
    );
  }
}
