import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:project_management/update_workspace.dart';
import 'package:project_management/workspace.dart';
import 'package:provider/provider.dart';

class DetailWorkspace extends StatefulWidget {
  const DetailWorkspace({super.key});

  @override
  State<DetailWorkspace> createState() => _DetailWorkspaceState();
}

class _DetailWorkspaceState extends State<DetailWorkspace> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final workspaceProvider =
        Provider.of<WorkspaceProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void deleteWorkspace() async {
      try {
        var response = await delete(
          Uri.parse(
              'https://api2.sib3.nurulfikri.com/api/workspace/${workspaceProvider.workspaceId}'),
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
          workspaceProvider.workspaceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateWorkspace(
                      workspaceName: workspaceProvider.workspaceName,
                      workspaceDescription:
                          workspaceProvider.workspaceDescription,
                      workspaceVisibility:
                          workspaceProvider.workspaceVisibility,
                    ),
                  ),
                ).then(
                  (value) => setState(() {}),
                );
              },
              icon: const Icon(Icons.edit_note)),
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
