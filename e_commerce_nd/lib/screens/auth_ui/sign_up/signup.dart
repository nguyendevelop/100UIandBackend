import 'package:e_commerce_nd/constants/constants.dart';
import 'package:e_commerce_nd/screens/auth_ui/login/login.dart';
import 'package:e_commerce_nd/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/routes.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
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
                  makeInput(
                    controllers: name,
                    label: "Name",
                    keyboard: TextInputType.name,
                  ),
                  makeInput(
                    controllers: email,
                    label: "Email",
                    keyboard: TextInputType.emailAddress,
                  ),
                  makeInput(
                    controllers: phone,
                    label: "Phone",
                    keyboard: TextInputType.phone,
                  ),
                  makeInput(
                    controllers: password,
                    label: "Password",
                    obscureText: true,
                    keyboard: TextInputType.visiblePassword,
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
                      bool isLogined = await FirebaseAuthHelper.instance
                          .signUp(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: const Home(), context: context);
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

  Widget makeInput({controllers, label, obscureText = false, keyboard}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controllers,
          obscureText: obscureText,
          keyboardType: keyboard,
          // decoration: InputDecoration(
          //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          //   enabledBorder:
          //       OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          //   border:
          //       OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          // ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
