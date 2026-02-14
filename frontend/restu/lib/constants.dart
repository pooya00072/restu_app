import 'package:flutter/material.dart';

const Color kBGColor = Color(0xFFF5F6F9);
const Color kGreyColor = Color(0xFF888888);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: '',
  hintStyle: TextStyle(
    color: kGreyColor,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBGColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreyColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);
