import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restu/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:restu/models/user.dart';
import 'package:restu/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  late RestuUser user;

  createUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.lock,
                  size: 100.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Welcome to Resto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Order Eat Enjoy!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kGreyColor,
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // ignore: unnecessary_null_comparison
                    if (email != "" && password != "") {
                      var url = Uri.parse(
                          'https://10.0.2.2:7256/api/RestuUser/$email');
                      var response = await http.get(url);
                      if (response.statusCode == 200) {
                        var body = convert.jsonDecode(response.body);
                        if (body['email'] == email &&
                            body['password'] == password) {
                          user = RestuUser(
                              body['id'],
                              body['fname'],
                              body['lname'],
                              email,
                              password,
                              body['address'],
                              body['phone']);
                          // Navigator.pushNamed(context, "home_screen",
                          //     arguments: user);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)));
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => RestuAlertWidget('Oops',
                              'You have entered your Email or your Password wrong'),
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => RestuAlertWidget(
                            "Oops", 'You should enter both email and password'),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => kGreyColor),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register_screen');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
