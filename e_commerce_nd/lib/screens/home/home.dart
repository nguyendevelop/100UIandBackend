import 'package:flutter/material.dart';

import '../../models/product_model/product_model.dart';
import '../../widgets/input_button/make_input.dart';
import '../../widgets/top_titles/top_titles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  // List<ProductModel> searchList = [];
  // void searchProducts(String value) {
  //   searchList = productModelList
  //       .where((element) =>
  //           element.name.toLowerCase().contains(value.toLowerCase()))
  //       .toList();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopTitles(title: "E Commerce", subtitle: ""),
                MakeInput(
                  controllers: search,
                  labels: "Search hera",
                  keyboardTypes: TextInputType.text,
                  decorations: const InputDecoration(hintText: "Search...."),
                  // onChangeds: (String value) {
                  // searchProducts(value);
                  // },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // makeInput(controllers: search, label: "Search",keyboardType: TextInputType.text),

            // TextFormField(
            //   controller: search,
            //   onChanged: (String value) {
            //     searchProducts(value);
            //   },
            //   decoration:
            //       const InputDecoration(hintText: "Search...."),
            // ),
          ),
        ],
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
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controllers,
          obscureText: obscureText,
          keyboardType: keyboard,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
