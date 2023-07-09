import 'package:e_commerce_nd/screens/auth_ui/login/login.dart';
import 'package:e_commerce_nd/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/routes.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  makeInput(label: "Email"),
                  makeInput(label: "Password", obscureText: true),
                  makeInput(label: "Confirm Password", obscureText: true),
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
                  onPressed: () {},
                  child: Text(
                    "Login",
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
                          routeNameToKeep: '/');
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

  Widget makeInput({label, obscureText = false}) {
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
          obscureText: obscureText,
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
