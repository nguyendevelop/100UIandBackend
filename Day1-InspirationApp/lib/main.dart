/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-06-28 22:48:45
 * @modify date 2023-06-28 22:48:45
 * @desc [Inspiration App]
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => ProductProvider()..fetchProducts(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find Your",
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Inspiration",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(244, 242, 242, 242),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        hintText: "Search you're looking for",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promo Today",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return PromoCard(
                          imageUrl: product.image,
                          categoryUrl: product.category,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  final String imageUrl;
  final String categoryUrl;

  const PromoCard({Key? key, required this.imageUrl, required this.categoryUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        // width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    stops: [0.1, 0.9],
                    colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.1),
                    ],
                  ),
                ),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        categoryUrl,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String image;
  final String category;

  Product({required this.image, required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(image: json['image'], category: json['category']);
  }
}

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.https('fakestoreapi.com', '/products'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      _products = jsonData.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
