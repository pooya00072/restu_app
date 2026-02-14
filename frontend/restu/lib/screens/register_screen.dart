import 'package:flutter/material.dart';
import 'package:restu/constants.dart';
import 'package:restu/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:restu/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String fName = '';
  String lName = '';
  String phone = '';
  String email = '';
  String address = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 35),
              Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: ListView(
                  children: [
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'First Name',
                      ),
                      onChanged: (value) {
                        fName = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Last Name',
                      ),
                      onChanged: (value) {
                        lName = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Phone',
                      ),
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Address',
                      ),
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 50),
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
                  'Register',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (fName != '' &&
                      lName != '' &&
                      phone != '' &&
                      email != '' &&
                      address != '' &&
                      password != '') {
                    var url = Uri.parse('https://10.0.2.2:7256/api/RestuUser');
                    var post = http.post(
                      url,
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: convert.jsonEncode({
                        "fname": fName,
                        "lname": lName,
                        "phone": phone,
                        "email": email,
                        "password": password,
                        "address": address
                      }),
                    );
                    post.whenComplete(
                        () => Navigator.pushNamed(context, "home_screen"));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Oops'),
                        content: Text('You should fill in all the fields'),
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
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
