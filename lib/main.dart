/**
 * @author [nguyendevelop]
 * @email [nguyendevelop@hotmail.com]
 * @create date 2023-07-02 08:38:58
 * @modify date 2023-07-02 08:38:58
 * @desc [Food Delivery App]
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => FoodProvider()..fetchFoods(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Icon(null),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.grey[800],
              ))
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodProvider.foods.length,
          itemBuilder: (context, index) {
            final food = foodProvider.foods[index];
            return Column(
              children: [
                Text(food.category),
              ],
            );
          },
        ),
      ),
    );
  }
}

class StarterPage extends StatelessWidget {
  bool _textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/afgprogrammer/Flutter-food-delivery-app-ui/master/assets/images/starter-image.jpg',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.bottomCenter, colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                ]),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextAnimation(
                        Text(
                          "Taking Order For Faster Delivery",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 70,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextAnimation(
                        Text("See restaurants nearby by \nadding location",
                            style: TextStyle(
                              color: Colors.white,
                              height: 1.4,
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StartButton(),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        child: Text(
                          "Now Deliver To Your Door 24/7",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class StartButton extends StatefulWidget {
  const StartButton({super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _textVisible = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _animation =
        Tween<double>(begin: 1.0, end: 35.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    _animationController.forward().then((f) => Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: TextAnimation(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.yellow,
                Colors.orange,
              ],
            ),
          ),
          child: AnimatedOpacity(
            opacity: _textVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 50),
            child: MaterialButton(
              onPressed: () => _onTap(),
              minWidth: double.infinity,
              child: Text(
                "Start",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Food {
  final String name;
  final int glass;
  final String image;
  final String category;

  Food({
    required this.name,
    required this.glass,
    required this.image,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['strDrink'],
      glass: json['strGlass'],
      image: json['strImageSource'],
      category: json['strCategory'],
    );
  }
}

class FoodProvider with ChangeNotifier {
  List<Food> _foods = [];
  List<Food> get foods => _foods;

  Future<void> fetchFoods() async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      _foods = jsonData.map((item) => Food.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception("Failed to fetch products");
    }
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
