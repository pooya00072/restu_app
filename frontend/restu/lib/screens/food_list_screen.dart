import 'dart:async';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:restu/models/food.dart';

import '../constants.dart';

class FoodListScreen extends StatefulWidget {
  final Future<List<RestuFood>> foods;

  const FoodListScreen({
    Key? key,
    required this.foods,
  }) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final _myBox = Hive.box('liked_food');
  final _cartBox = Hive.box('cart');

  final List<String> types = ['Burger', 'Pizza', 'Sandwich'];
  String selectedValue = 'Burger';

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
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => kGreyColor.withOpacity(0.6)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Select Food Type',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomDropdownButton2(
                    hint: 'Select Food Type',
                    dropdownItems: types,
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                flex: 6,
                child: FutureBuilder<List<RestuFood>>(
                  future: widget.foods,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final foods = snapshot.data!;
                      return buildRestuFoods(foods, selectedValue);
                    } else {
                      return const Text("No Food data.");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRestuFoods(List<RestuFood> foods, String sType) =>
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: ((context, index) {
          final food = foods[index];
          if (food.type == sType) {
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
