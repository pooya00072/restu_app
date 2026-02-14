import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restu/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: Container(
              color: kBGColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // child: Image.asset('images/history.png'),
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
                          child: Text('Last Order',
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
                        Image.asset('images/history.png'),
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
