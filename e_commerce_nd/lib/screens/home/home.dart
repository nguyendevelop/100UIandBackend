import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_nd/helper/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:e_commerce_nd/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/input_button/make_input.dart';
import '../../widgets/top_titles/top_titles.dart';
import '../category_view/category_view.dart';
import '../product_details/product_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  // List<ProductModel> searchList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getCategoryList();

    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 18.0,
                        ),
                        TopTitles(title: "E Commerce", subtitle: ""),
                        MakeInput(
                          controllers: search,
                          labels: "Search here",
                          keyboardTypes: TextInputType.text,
                          decorations:
                              const InputDecoration(hintText: "Search...."),
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
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Best Products",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Best products is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.7,
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Image.network(
                                        singleProduct.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Price: \$${singleProduct.price}"),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 130,
                                        padding:
                                            EdgeInsets.only(top: 3, left: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              top: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black),
                                            )),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.greenAccent),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              )),
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          child: const Text(
                                            "Detail",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                ],
              ),
            ),
    );
  }
}
