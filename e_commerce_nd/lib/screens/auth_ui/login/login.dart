// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_nd/constants/asset_image.dart';
import 'package:e_commerce_nd/constants/constants.dart';
import 'package:e_commerce_nd/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_commerce_nd/screens/home/home.dart';
import 'package:e_commerce_nd/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/routes.dart';
import '../../../widgets/input_button/make_input.dart';
import '../sign_up/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopTitles(title: "Login", subtitle: "Login to your account"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        MakeInput(
                          controllers: email,
                          labels: "Email",
                          keyboardTypes: TextInputType.emailAddress,
                          decorations: InputDecoration(
                            hintText: "E-mail",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        MakeInput(
                          controllers: password,
                          labels: "Password",
                          obscureTexts: true,
                          keyboardTypes: TextInputType.visiblePassword,
                          decorations: InputDecoration(
                            hintText: "Password",
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
                                isShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    // child: Container(
                    //   padding: EdgeInsets.only(top: 3, left: 3),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       border: Border(
                    //         bottom: BorderSide(color: Colors.black),
                    //         top: BorderSide(color: Colors.black),
                    //         left: BorderSide(color: Colors.black),
                    //         right: BorderSide(color: Colors.black),
                    //       )),
                    //   child: MaterialButton(
                    //     minWidth: double.infinity,
                    //     height: 60,
                    //     onPressed: () {},
                    //     color: Colors.greenAccent,
                    //     elevation: 0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(50)),
                    //     child: Text(
                    //       "Login",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w600, fontSize: 18),
                    //     ),
                    //   ),
                    // ),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(50),
                            )),
                        onPressed: () async {
                          bool isVaildated =
                              loginVaildation(email.text, password.text);
                          if (isVaildated) {
                            bool isLogined = await FirebaseAuthHelper.instance
                                .login(email.text, password.text, context);
                            if (isLogined) {
                              Routes.instance.pushAndRemoveUntil(
                                  widget: Home(), context: context);
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Routes.instance.pushAndRemoveUntil(
                            widget: const SignUp(),
                            context: context,
                            routeNameToKeep: '/',
                          );
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsImages.instance.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget makeInput({controllers, label, obscureText = false, keyboard}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
  //       ),
  //       const SizedBox(
  //         height: 5,
  //       ),
  //       TextField(
  //         controller: controllers,
  //         obscureText: obscureText,
  //         keyboardType: keyboard,
  //       ),
  //       const SizedBox(
  //         height: 30,
  //       ),
  //     ],
  //   );
  // }
}
