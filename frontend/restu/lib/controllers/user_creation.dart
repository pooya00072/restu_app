import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:restu/models/user.dart';

void createUser(String email, String password) async {
  late RestuUser user;
  var url = Uri.parse('https://10.0.2.2:7256/api/RestuUser/$email');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var body = convert.jsonDecode(response.body);
    if (body['email'] == email && body['password'] == password) {
      user = RestuUser(body['id'], body['fname'], body['lname'], email,
          password, body['address'], body['phone']);
    }
    // Navigator.pushNamed(context, "home_screen",
    //     arguments: user);
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => HomeScreen(user: user)));
  }
}
