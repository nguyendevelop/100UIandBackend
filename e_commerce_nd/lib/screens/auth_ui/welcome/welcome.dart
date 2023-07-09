import 'package:e_commerce_nd/constants/asset_image.dart';
import 'package:e_commerce_nd/screens/auth_ui/login/login.dart';
import 'package:e_commerce_nd/screens/auth_ui/sign_up/signup.dart';
import 'package:e_commerce_nd/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../../../constants/theme.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopTitles(
                  title: "Welcome", subtitle: "Buy any item from using app"),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsImages.instance.welcomeImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Login()));
                      Routes.instance
                          .push(widget: const Login(), context: context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                    // child: MaterialButton(
                    //   minWidth: double.infinity,
                    //   height: 60,
                    //   onPressed: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => SignUp()));
                    //   },
                    //   color: Colors.yellow,
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(50)),
                    //   child: Text(
                    //     "Sign up",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w600, fontSize: 18),
                    //   ),
                    // ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(50),
                          )),
                      onPressed: () {
                        Routes.instance
                            .push(widget: const SignUp(), context: context);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          print("click facebook icon");
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.facebook,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          print("click google icon");
                        },
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          AssetsImages.instance.googleLogo,
                          scale: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
