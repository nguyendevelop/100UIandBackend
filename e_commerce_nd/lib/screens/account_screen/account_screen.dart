import 'package:e_commerce_nd/screens/about_screen/about_us_screen.dart';
import 'package:e_commerce_nd/screens/favorite_screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../provider/app_provider.dart';
import '../auth_ui/change_password/change_password.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // appProvider.getUserInformation.image == null
                //     ? const Icon(
                //         Icons.person_outline,
                //         size: 120,
                //       )
                //     : CircleAvatar(
                //         backgroundImage:
                //             NetworkImage(appProvider.getUserInformation.image!),
                //         radius: 60,
                //       ),
                Text("image profile"),
                // Text(
                //   appProvider.getUserInformation.name,
                //   style: const TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   appProvider.getUserInformation.email,
                // ),
                // const SizedBox(
                //   height: 12.0,
                // ),
                // SizedBox(
                //   width: 130,
                //   child: PrimaryButton(
                //     title: "Edit Profile",
                //     onPressed: () {
                //       Routes.instance
                //           .push(widget: const EditProfile(), context: context);
                //     },
                //   ),
                // )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    // Routes.instance
                    //     .push(widget: const OrderScreen(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const FavoriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourite"),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('AlertDialog Title'),
                        content: const Text('Product by Nguyen Develop'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('!Got It'),
                          ),
                        ],
                      ),
                    );
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    //
                  },
                  leading: const Icon(Icons.delete_sweep_outlined),
                  title: const Text("Detele account"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();

                    // setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Log out"),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("Alpha Version")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
