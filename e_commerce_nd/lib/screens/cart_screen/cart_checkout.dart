import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../helper/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../helper/stripe_helper/stripe_helper.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';

class CartCheckout extends StatefulWidget {
  final ProductModel singleProduct;
  const CartCheckout({super.key, required this.singleProduct});

  @override
  State<CartCheckout> createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Check out",
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
              child: Text("Continues"),
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          context,
                          "Cash on delivery");

                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Routes.instance.push(
                          widget: const CustomBottomBar(), context: context);
                    });
                  }
                } else {
                  int value = double.parse(
                          appProvider.totalPriceBuyProductList().toString())
                      .round()
                      .toInt();
                  String totalPrice = (value * 100).toString();
                  await StripeHelper.instance
                      .makePayment(totalPrice.toString(), context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
