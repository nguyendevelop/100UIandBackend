import 'package:e_commerce_nd/screens/cart_screen/cart_checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../../widgets/cart_screen/single_cart_item.dart';
import 'cart_item_checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cart Screen",
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
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
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
                  onPressed: () {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProductCartList();
                    appProvider.clearCart();
                    if (appProvider.getBuyProductList.isEmpty) {
                      showMessage("Cart is empty");
                    } else {
                      Routes.instance.push(
                          widget: const CartItemCheckout(), context: context);
                    }
                    Routes.instance
                        .push(widget: CartItemCheckout(), context: context);
                  },
                  child: Text("Checkout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
