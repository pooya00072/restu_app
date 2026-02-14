import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:restu/constants.dart';
import 'package:restu/models/food.dart';
import 'package:restu/models/user.dart';
import 'home_pages/account_page.dart';
import 'home_pages/cart_page.dart';
import 'home_pages/favorites_page.dart';
import 'home_pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  final RestuUser user;

  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    try {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
    } catch (e) {
      print('');
    }
  }

  late List<Widget> screens;
  Future<List<RestuFood>> foods = getFoods();

  static Future<List<RestuFood>> getFoods() async {
    const url = 'https://10.0.2.2:7256/api/Food';
    final response = await http.get(Uri.parse(url));
    final body = convert.json.decode(response.body);
    return body.map<RestuFood>(RestuFood.fromJson).toList();
  }

  @override
  void initState() {
    super.initState();
    screens = [
      HomePage(widget.user, foods),
      FavoritesPage(foods),
      CartPage(),
      AccountPage(widget.user),
    ];
    // populateFoods(foods);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screens,
      ),
      // body: Center(
      //   child: FutureBuilder<List<RestuFood>>(
      //     future: foods,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const CircularProgressIndicator();
      //       } else if (snapshot.hasData) {
      //         final foods = snapshot.data!;
      //         return buildRestuFoods(foods);
      //       } else {
      //         return const Text("No Food data.");
      //       }
      //     },
      //   ),
      // ),
      backgroundColor: kBGColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
            ),
            label: 'Favorites ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget buildRestuFoods(List<RestuFood> foods) => ListView.builder(
        itemCount: foods.length,
        itemBuilder: ((context, index) {
          final food = foods[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.amber,
              ),
              title: Text(food.type),
              subtitle: Text(food.name),
            ),
          );
        }),
      );
}
