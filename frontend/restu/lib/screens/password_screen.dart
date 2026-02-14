import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restu/constants.dart';
import 'package:restu/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PasswordScreen extends StatefulWidget {
  final RestuUser user;
  const PasswordScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late String password;
  late String currentPassowrd;
  late String doubleCheck;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   password = widget.user.password;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Current Password',
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          TextField(
                            decoration: kTextFieldDecoration.copyWith(
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              currentPassowrd = value;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'New Password',
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          TextField(
                            decoration: kTextFieldDecoration.copyWith(
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Retype Password',
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          TextField(
                            decoration: kTextFieldDecoration.copyWith(
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              doubleCheck = value;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (currentPassowrd == widget.user.password) {
                                    if (password == doubleCheck) {
                                      var url = Uri.parse(
                                          'https://10.0.2.2:7256/api/RestuUser');
                                      var update = http.put(
                                        url,
                                        headers: {
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: convert.jsonEncode({
                                          "id": widget.user.id,
                                          "fname": widget.user.fName,
                                          "lname": widget.user.lName,
                                          "phone": widget.user.phone,
                                          "email": widget.user.email,
                                          "password": password,
                                          'address': widget.user.address,
                                        }),
                                      );
                                      update.whenComplete((() {
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                'login_screen'));
                                      }));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Oops'),
                                          content: Text(
                                              'Re Entered password is wrong!'),
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
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Oops'),
                                        content: Text('Wrong Password'),
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
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
