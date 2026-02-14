import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restu/screens/home_screen.dart';
import 'package:restu/screens/login_screen.dart';
import 'package:restu/screens/register_screen.dart';

import 'models/food.dart';

void main() async {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();

  // initialize hive
  await Hive.initFlutter();

  // Register Adapter
  Hive.registerAdapter(RestuFoodAdapter());

  // open the box
  await Hive.openBox('liked_food');
  await Hive.openBox('cart');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restu',
      initialRoute: 'login_screen',
      routes: {
        'login_screen': (context) => const LoginScreen(),
        'register_screen': (context) => const RegisterScreen(),
        // 'home_screen': (context) => const HomeScreen(),
      },
    );
  }
}
