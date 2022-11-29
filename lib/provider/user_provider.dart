import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _accessToken = "";
  String get accessToken => _accessToken;

  setAccessToken(String token) {
    _accessToken = token;
  }
}
