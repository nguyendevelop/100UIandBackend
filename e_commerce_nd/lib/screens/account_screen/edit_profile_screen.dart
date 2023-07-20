import 'dart:io';

import 'package:e_commerce_nd/constants/constants.dart';
import 'package:e_commerce_nd/helper/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:e_commerce_nd/widgets/input_button/make_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../helper/firebase_helper/firebase_firestorage_helper/firebase_firestorage_helper.dart';
import '../../models/user_model.dart';
import '../../provider/app_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController changeName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    print("object1");
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    print("object2");

                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          MakeInput(
            controllers: changeName,
            keyboardTypes: TextInputType.name,
            decorations: InputDecoration(
              hintText: appProvider.getUserInformation.name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            // onPressed: () async {
            //   String imageUrl =
            //       await FirebaseStorageHelper.instance.uploadUserImage(image!);
            //   print("update click");
            //   print(imageUrl);
            // },
            onPressed: () async {
              UserModel userModel = appProvider.getUserInformation
                  .copyWith(name: changeName.text);
              appProvider.updateUserInfoFirebase(context, userModel, image);
            },
            child: Text(
              "Update",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
