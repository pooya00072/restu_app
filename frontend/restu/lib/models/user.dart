import 'package:flutter/material.dart';

class RestuUser {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String address;
  String password;

  RestuUser(this.id, this.fName, this.lName, this.email, this.password,
      this.address, this.phone);
}
