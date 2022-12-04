import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/workspace.dart';
import 'package:provider/provider.dart';

class DetailWorkspace extends StatelessWidget {
  const DetailWorkspace(
      {super.key, required this.workspaceName, required this.workspaceId});
  final String workspaceName;
  final String workspaceId;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void deleteWorkspace() async {
      try {
        var response = await delete(
          Uri.parse(
              'https://api2.sib3.nurulfikri.com/api/workspace/$workspaceId'),
          headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          sMessenger.showSnackBar(
            SnackBar(
              content: Text(responseBody['info']),
            ),
          );

          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Workspace(),
            ),
            (route) => false,
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          workspaceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_note)),
          IconButton(
              onPressed: () {
                deleteWorkspace();
              },
              icon: const Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_add)),
        ],
      ),
    );
  }
}
