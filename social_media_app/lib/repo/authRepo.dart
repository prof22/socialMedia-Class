import 'package:http/http.dart' as http;
import 'package:social_media_app/util/constants.dart';
import 'dart:convert';

class AuthRep {
  String registerUrl = "/auth/register";
  String loginUrl = "/auth/login";

  //  'Authorization': 'Bearer $token',

  Future register(username, email, password) async {
    dynamic body = {
      "username": username,
      "email": email,
      "password": password,
    };
    final response = await http.post(
      Uri.parse("$apiUrl$registerUrl"),
      body: jsonEncode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future login(email, password) async {
    dynamic body = {
      "email": email,
      "password": password,
    };
    final response = await http.post(
      Uri.parse("$apiUrl$loginUrl"),
      body: jsonEncode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
