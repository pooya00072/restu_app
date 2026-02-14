import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:restu/constants.dart';
import 'package:restu/models/user.dart';
import 'package:restu/screens/account_information_screen.dart';
import 'package:restu/screens/address_information_screen.dart';
import 'package:restu/screens/history.dart';
import 'package:restu/screens/password_screen.dart';
import '../notification_screen.dart';

class AccountPage extends StatefulWidget {
  final RestuUser user;
  const AccountPage(this.user);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              color: Colors.white,
              child: Builder(
                builder: (BuildContext context) {
                  final user = widget.user;
                  return buildAccountInfo(user);
                },
              ),
            )),
      ),
    );
  }
}

Widget buildAccountInfo(RestuUser user) => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: ((context, index) {
        final userr = user;

        return Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: kBGColor,
                    radius: 42,
                    child: Text(
                      user.fName[0].toUpperCase() + user.lName[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fName.toUpperCase() +
                            ' ' +
                            user.lName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: kGreyColor,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => kGreyColor.withOpacity(0.6)),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 44,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationScreen()));
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                          size: 34,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            'Account Information',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AccountInformationScreen(user: user)));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.black,
                          size: 34,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            'Address Information',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddressInformationScreen(user: user)));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.key_sharp,
                          color: Colors.black,
                          size: 34,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PasswordScreen(user: user)));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.black,
                          size: 34,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            'Last Order',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HistoryScreen()));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: Colors.black,
                          size: 34,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => kGreyColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
