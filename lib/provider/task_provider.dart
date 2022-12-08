import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  String _id = '';
  String get id => _id;

  setTaskId(String id) {
    _id = id;
  }
}
