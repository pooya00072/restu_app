import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:restu/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        Center(
                          child: Text('Notifications',
                              style: GoogleFonts.lobsterTwo(
                                color: Colors.black,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(18),
                          height: 2,
                          color: Colors.black,
                        ),
                        const Center(
                          child: Text(
                            'There is not any notification',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
