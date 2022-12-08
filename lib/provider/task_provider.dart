import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  int _id = 0;
  int get id => _id;

  setTaskId(int id) {
    _id = id;
  }
}
