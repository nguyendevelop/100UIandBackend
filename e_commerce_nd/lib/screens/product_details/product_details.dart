import 'package:e_commerce_nd/models/product_model.dart';
import 'package:e_commerce_nd/provider/app_provider.dart';
import 'package:e_commerce_nd/screens/cart_screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../constants/routes.dart';
import '../cart_screen/cart_checkout.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
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
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavorite =
                            !widget.singleProduct.isFavorite;
                      });
                      if (widget.singleProduct.isFavorite) {
                        appProvider.addFavoriteProduct(widget.singleProduct);
                        print("addFavoriteProduct favorite");
                      } else {
                        appProvider.removeFavoriteProduct(widget.singleProduct);
                        print("removeFavoriteProduct favorite");
                      }
                    },
                    icon: Icon(appProvider.getFavoriteProductList
                            .contains(widget.singleProduct)
                        // Icon(widget.singleProduct.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              Text(widget.singleProduct.description),
              const SizedBox(
                height: 12.00,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Added to Cart");
                    },
                    child: const Text("ADD TO CART"),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        Routes.instance.push(
                          widget: CartCheckout(
                            singleProduct: productModel,
                          ),
                          context: context,
                        );
                      },
                      child: const Text("BUY"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
