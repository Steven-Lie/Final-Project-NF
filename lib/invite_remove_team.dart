import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:provider/provider.dart';

class InviteRemoveTeam extends StatelessWidget {
  const InviteRemoveTeam({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final workspaceProvider =
        Provider.of<WorkspaceProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final emailController = TextEditingController();

    void removeTeam() async {
      try {
        var response = await delete(
            Uri.parse(
                'https://api2.sib3.nurulfikri.com/api/workspace/remove/${workspaceProvider.workspaceId}'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              'email': emailController.text,
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == 200) {
          navigator.pop();
        }
      } catch (e) {
        log(e.toString());
      }
    }

    void addTeam() async {
      try {
        var response = await post(
            Uri.parse(
                'https://api2.sib3.nurulfikri.com/api/workspace/invite/${workspaceProvider.workspaceId}'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              'email': emailController.text,
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == 200) {
          navigator.pop();
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Invite/Remove Team',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'e.g. hello@gmail.com',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF787878),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0XFF4C53FF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Choose Action',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      removeTeam();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Remove'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addTeam();
                    },
                    child: const Text('Add'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
