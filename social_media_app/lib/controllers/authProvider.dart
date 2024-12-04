import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/repo/authRepo.dart';

class Authprovider extends ChangeNotifier {
  AuthRep _repos = AuthRep();
  // for register
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> registerUser(username, email, password) async {
    _isLoading = true;
    notifyListeners();
    final response = await _repos.register(username, email, password);
    if (response.statusCode == 201) {
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  //for login
  Future<bool> loginUser(email, password) async {
    _isLoading = true;
    notifyListeners();
    final response = await _repos.login(email, password);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }
}
