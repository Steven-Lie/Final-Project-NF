import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatelessWidget {
  CreateTask({Key? key}) : super(key: key);

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final workspaceProvider =
        Provider.of<WorkspaceProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void createTask() async {
      try {
        var response = await post(
            Uri.parse('https://api2.sib3.nurulfikri.com/api/workspace/task'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              'workspace_id': workspaceProvider.workspaceId,
              'title': _taskNameController.text,
              'description': _taskDescriptionController.text,
              'status': '1',
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == '00') {
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
          'Create Task',
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
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Color(0XFF4C53FF),
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0XFF4C53FF), width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  helperText: "This is the name of your task",
                  alignLabelWithHint: true,
                  helperStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _taskDescriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Color(0XFF4C53FF),
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0XFF4C53FF), width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  helperText:
                      "Get your members on board with a few words about the task.",
                  alignLabelWithHint: true,
                  helperStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  createTask();
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
    );
  }
}
