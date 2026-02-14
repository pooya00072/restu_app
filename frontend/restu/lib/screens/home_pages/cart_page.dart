import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'dart:math';
import '../../constants.dart';
import '../../models/food.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cart = Hive.box('cart');
  double totalPrice = 0;

  void updatePrice() {
    for (var item in _cart.values.toList()) {
      totalPrice += item.price;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePrice();
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.0, 24, 24, 6),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Text('Your Cart',
                      style: GoogleFonts.lobsterTwo(
                        color: Colors.black,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              flex: 10,
              child: Builder(
                builder: (BuildContext context) {
                  final foods = _cart.values.toList();

                  return buildRestuFoods(foods);
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.0, 12, 12, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Item total'),
                              Text(roundDouble(totalPrice, 2).toString() +
                                  " TL"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Delivery'),
                              Text('Free'),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(12.0),
                            height: 2,
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Total'),
                              Text(roundDouble(totalPrice, 2).toString() +
                                  " TL"),
                            ],
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 9,
                                ),
                              ),
                            ),
                            child: Text(
                              'Check Out',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: _cart.isEmpty
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => RestuAlertWidget(
                                        "Oops",
                                        "Your cart is empty!",
                                      ),
                                    );
                                  }
                                : (() {
                                    setState(() {
                                      _cart.clear();
                                      totalPrice = 0;
                                      showDialog(
                                        context: context,
                                        builder: (context) => RestuAlertWidget(
                                          "Thanks For your order!",
                                          "We received your order, it will be delivered soon!",
                                        ),
                                      );
                                      RestuAlertWidget(
                                        "Thanks For your order!",
                                        "We received your order, it will be delivered soon!",
                                      );
                                    });
                                  }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRestuFoods(List<dynamic> foods) => ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: ((context, index) {
          final food = foods[index];

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
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0)),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              if (!food.decreaseCount()) {
                                _cart.delete(food.id);
                              }
                              totalPrice = totalPrice - food.price;
                            });
                          },
                        ),
                        Text(
                          food.count.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0)),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              food.increaseCount();
                              totalPrice = totalPrice + food.price;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
}

class RestuAlertWidget extends StatelessWidget {
  String title;
  String contents;

  RestuAlertWidget(this.title, this.contents, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title), //Changable
      content: Text(contents), // Changable
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Ok',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
