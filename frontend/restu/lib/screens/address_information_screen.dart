import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restu/constants.dart';
import 'package:restu/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddressInformationScreen extends StatefulWidget {
  final RestuUser user;
  const AddressInformationScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AddressInformationScreen> createState() =>
      _AddressInformationScreenState();
}

class _AddressInformationScreenState extends State<AddressInformationScreen> {
  late String address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address = widget.user.address;
  }

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
                            'Address',
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          TextField(
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: address,
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                          SizedBox(height: 410),
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
                                      "password": widget.user.password,
                                      'address': address,
                                    }),
                                  );
                                  update.whenComplete((() {
                                    Navigator.popUntil(context,
                                        ModalRoute.withName('login_screen'));
                                  }));
                                },
                              ),
                            ],
                          ),
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
