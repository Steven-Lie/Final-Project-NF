import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  int _id = 0;
  String? _title = "";
  String? _description = "";
  String? _status = "";
  String? _label = "";
  String? _milestone = "";
  String? _progress = "";

  int get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get status => _status;
  String? get label => _label;
  String? get milestone => _milestone;
  String? get progress => _progress;

  setTaskId(int id) {
    _id = id;
  }

  setTitle(String? title) {
    _title = title;
  }

  setDescription(String? desc) {
    _description = desc;
  }

  setStatus(String? status) {
    _status = status;
  }

  setLabel(String? label) {
    _label = label;
  }

  setMilestone(String? milestone) {
    _milestone = milestone;
  }

  setProgress(String? progress) {
    _progress = progress;
  }
}
