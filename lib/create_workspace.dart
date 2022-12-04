import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/workspace.dart';
import 'package:provider/provider.dart';

class CreateWorkspace extends StatelessWidget {
  CreateWorkspace({super.key});

  final _workspaceNameController = TextEditingController();
  final _workspaceDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void createWorkspace() async {
      try {
        var response = await post(
            Uri.parse('https://api2.sib3.nurulfikri.com/api/workspace'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              'name': _workspaceNameController.text,
              'description': _workspaceDescriptionController.text,
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == 200) {
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const Workspace(),
              ),
              (route) => false);
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Workspace',
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
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _workspaceNameController,
                  decoration: InputDecoration(
                    labelText: 'Workspace Name',
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
                    helperText: "This is the name of your workspace",
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _workspaceDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
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
                    helperText:
                        "Get your members on board with a few words about your workspace",
                    alignLabelWithHint: true,
                  ),
                  maxLines: 8,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    createWorkspace();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
