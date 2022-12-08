import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:provider/provider.dart';

class UpdateWorkspace extends StatefulWidget {
  const UpdateWorkspace(
      {super.key,
      required this.workspaceName,
      required this.workspaceDescription,
      required this.workspaceVisibility});
  final String workspaceName;
  final String workspaceDescription;
  final String workspaceVisibility;

  @override
  State<UpdateWorkspace> createState() => _UpdateWorkspaceState();
}

class _UpdateWorkspaceState extends State<UpdateWorkspace> {
  String? _radioValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _radioValue = widget.workspaceVisibility;
    nameController = TextEditingController(text: widget.workspaceName);
    descriptionController =
        TextEditingController(text: widget.workspaceDescription);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final workspaceProvider =
        Provider.of<WorkspaceProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void updateWorkspace() async {
      try {
        var response = await put(
            Uri.parse(
                'https://api2.sib3.nurulfikri.com/api/workspace/${workspaceProvider.workspaceId}'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              'name': nameController.text,
              'description': descriptionController.text,
              'visibility': _radioValue,
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == 200) {
          workspaceProvider.setId(responseBody['data']['id']);
          workspaceProvider.setName(responseBody['data']['name']);
          workspaceProvider.setDescription(responseBody['data']['description']);
          workspaceProvider.setVisibility(responseBody['data']['visibility']);
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
                  controller: nameController,
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
                  controller: descriptionController,
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
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text("Visibility"),
                const SizedBox(
                  height: 8.0,
                ),
                RadioListTile(
                  value: "team",
                  groupValue: _radioValue,
                  onChanged: (value) => setState(() {
                    _radioValue = value;
                  }),
                  title: const Text('Team'),
                ),
                RadioListTile(
                  value: "personal",
                  groupValue: _radioValue,
                  onChanged: (value) => setState(() {
                    _radioValue = value;
                  }),
                  title: const Text('Personal'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateWorkspace();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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
