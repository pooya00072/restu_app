import 'dart:async';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import '../../models/food.dart';

class FavoritesPage extends StatefulWidget {
  Future<List<RestuFood>> foods;

  FavoritesPage(this.foods);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _myBox = Hive.box('liked_food');
  final _cartBox = Hive.box('cart');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _myBox.watch();
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);

  void handleTimeout() {
    try {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
    } catch (e) {
      print('');
    }
  }

  void showBanner(String message) => ScaffoldMessenger.of(context)
    ..removeCurrentMaterialBanner()
    ..showMaterialBanner(
      MaterialBanner(
        backgroundColor: kGreyColor.withOpacity(0.3),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => kGreyColor.withOpacity(0.5)),
            ),
            child: Center(
              child: Text(
                'Dismiss',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: (() =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner()),
          )
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Text('Favorites',
                    style: GoogleFonts.lobsterTwo(
                      color: Colors.black,
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              child: FutureBuilder<List<RestuFood>>(
                future: widget.foods,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final foods = snapshot.data!;
                    final likedFoods = _myBox.toMap().keys.toList();
                    return buildRestuFoods(foods, likedFoods);
                  } else {
                    return const Text("No Food data.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRestuFoods(List<RestuFood> foods, List likedFoods) =>
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: ((context, index) {
          final food = foods[index];
          if (likedFoods.contains(food.id)) {
            return TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => kGreyColor.withOpacity(0.1)),
              ),
              onPressed: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: kGreyColor,
                            // child: Icon(Icons.arrow_back),
                          ),
                          title: Text(food.name),
                          subtitle: Text(food.price.toString() + "TL"),
                        ),
                      ),
                      Column(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => kGreyColor.withOpacity(0.3)),
                            ),
                            child: Icon(
                              _myBox.get(food.id) != null
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.black,
                              size: 26,
                            ),
                            onPressed: () {
                              setState(() {
                                _myBox.get(food.id) == null
                                    ? _myBox.put(food.id, true)
                                    : _myBox.delete(food.id);
                              });
                            },
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => kGreyColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              _cartBox.get(food.id) == null
                                  ? 'Add to cart'
                                  : "In cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (_cartBox.get(food.id) == null) {
                                setState(() {
                                  _cartBox.put(food.id, food.clone(food));
                                });
                                var foodname = food.name;
                                showBanner('"$foodname" Added to cart!');
                                scheduleTimeout(2 * 1000);
                              } else {
                                var foodname = food.name;
                                showBanner('"$foodname" is Already in cart!');
                                scheduleTimeout(2 * 1000);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      );
}
