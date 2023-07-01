/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-06-29 09:40:06
 * @modify date 2023-06-29 09:40:06
 * @desc [Trip App]
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip App',
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
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          final totalIds = productProvider.totalIds();
          return MakePage(
            idUrl: product.id,
            titleUrl: product.title,
            descriptionUrl: product.description,
            ratingRateUrl: product.ratingRate,
            ratingCountUrl: product.ratingCount,
            imageUrl: product.image,
            totalIds: totalIds,
          );
        },
      ),
    );
  }
}

class MakePage extends StatelessWidget {
  final String idUrl;
  final String titleUrl;
  final String descriptionUrl;
  final double ratingRateUrl;
  final int ratingCountUrl;
  final String imageUrl;
  final int totalIds;

  const MakePage({
    Key? key,
    required this.idUrl,
    required this.titleUrl,
    required this.descriptionUrl,
    required this.ratingRateUrl,
    required this.ratingCountUrl,
    required this.imageUrl,
    required this.totalIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratingRateValue = ratingRateUrl;
    //làm tròn giá trị ratingValue thành một số nguyên và gán cho biến numberOfStars
    int numberOfStars = ratingRateValue.round();

    int ratingCountValue = ratingCountUrl;

    List<Widget> stars = List.generate(
      5,
      (index) => Icon(
        index < numberOfStars ? Icons.star : Icons.star_border,
        color: Colors.yellow,
        size: 20,
      ),
    );

    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          //chiếm toàn bộ màn widget cha của stack
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: [0.3, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
              // child: Container(
              //   alignment: Alignment.topRight,
              //   padding: EdgeInsets.all(16),
              //   child: Text(
              //     idUrl,
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          idUrl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/$totalIds',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAnimation(
                          Text(
                            titleUrl,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextAnimation(
                          Row(
                            children: [
                              Row(
                                children: stars,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                ratingRateValue.toString(),
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                ' ($ratingCountValue)'.toString(),
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextAnimation(
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: ReadMoreText(
                              descriptionUrl,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  height: 1.9,
                                  fontSize: 15),
                              trimLines: 4,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  height: 1.9,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final double ratingRate;
  final int ratingCount;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.ratingRate,
    required this.ratingCount,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'] as Map<String, dynamic>;

    final rate = ratingData['rate'].toDouble();
    final count = ratingData['count'] as int;

    return Product(
        id: json['id'].toString(),
        title: json['title'],
        description: json['description'],
        ratingRate: rate,
        ratingCount: count,
        image: json['image']);
  }
}

class ProductProvider with ChangeNotifier {
  bool showFullDescription = false;

  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.https('fakestoreapi.com', '/products'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      _products = jsonData.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception("Failed to fetch products");
    }
  }

  int totalIds() {
    return _products.length;
  }

  void toggleDescription() {
    showFullDescription = !showFullDescription;
    notifyListeners();
  }
}

class TextAnimation extends StatelessWidget {
  final Widget child;

  const TextAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeIn,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
