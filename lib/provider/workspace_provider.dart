import 'package:flutter/material.dart';

class WorkspaceProvider with ChangeNotifier {
  String _workspaceId = "";
  String _workspaceName = "";
  String _workspaceDescription = "";
  String _workspaceVisibility = "";

  String get workspaceId => _workspaceId;
  String get workspaceName => _workspaceName;
  String get workspaceDescription => _workspaceDescription;
  String get workspaceVisibility => _workspaceVisibility;

  setId(String id) {
    _workspaceId = id;
  }

  setName(String name) {
    _workspaceName = name;
  }

  setDescription(String description) {
    _workspaceDescription = description;
  }

  setVisibility(String visibility) {
    _workspaceVisibility = visibility;
  }
}
