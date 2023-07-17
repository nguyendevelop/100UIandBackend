import 'package:e_commerce_nd/constants/constants.dart';
import 'package:e_commerce_nd/screens/auth_ui/login/login.dart';
import 'package:e_commerce_nd/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/routes.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../widgets/input_button/make_input.dart';
import '../../home/home.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TopTitles(
                  title: "Sign up", subtitle: "Create an account, It's free"),
              Column(
                children: [
                  MakeInput(
                    controllers: name,
                    labels: "Name",
                    keyboardTypes: TextInputType.name,
                    decorations: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  MakeInput(
                    controllers: email,
                    labels: "Email",
                    keyboardTypes: TextInputType.emailAddress,
                    decorations: const InputDecoration(
                      hintText: "E-mail",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  MakeInput(
                    controllers: phone,
                    labels: "Phone",
                    keyboardTypes: TextInputType.phone,
                    decorations: const InputDecoration(
                      hintText: "Phone",
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                      ),
                    ),
                  ),
                  MakeInput(
                    controllers: password,
                    labels: "Password",
                    obscureTexts: isShowPassword,
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
                          child: const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ],
              ),
              Container(
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
                    bool isVaildated = signUpVaildation(
                      email.text,
                      password.text,
                      name.text,
                      phone.text,
                    );
                    if (isVaildated) {
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(
                          name.text, email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: Home(), context: context);
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Routes.instance.pushAndRemoveUntil(
                        widget: Login(),
                        context: context,
                        routeNameToKeep: '/',
                      );
                    },
                    child: Text(
                      " Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  //       SizedBox(
  //         height: 5,
  //       ),
  //       TextField(
  //         controller: controllers,
  //         obscureText: obscureText,
  //         keyboardType: keyboard,
  //         // decoration: InputDecoration(
  //         //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //         //   enabledBorder:
  //         //       OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  //         //   border:
  //         //       OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  //         // ),
  //       ),
  //       SizedBox(
  //         height: 30,
  //       ),
  //     ],
  //   );
  // }
}
