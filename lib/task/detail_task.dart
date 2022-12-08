import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/task_provider.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class DetailTask extends StatefulWidget {
  const DetailTask({super.key});

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    Future<dynamic> getTask() async {
      try {
        var response = await get(
          Uri.parse(
              'https://api2.sib3.nurulfikri.com/api/workspace/task/${taskProvider.id}'),
          headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
        );
        return jsonDecode(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

    void deleteTask() async {
      try {
        var response = await delete(
          Uri.parse(
              'https://api2.sib3.nurulfikri.com/api/workspace/task/${taskProvider.id}'),
          headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          sMessenger.showSnackBar(
            SnackBar(
              content: Text(responseBody['info']),
            ),
          );

          navigator.pop();
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
          "Task",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsPadding: const EdgeInsets.only(bottom: 20.0),
                    title: const Text("Delete This Task?"),
                    content:
                        const Text("Deleted items will be permanently deleted"),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton(
                        onPressed: () => navigator.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF787878),
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => deleteTask(),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: getTask(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['code'] == "00") {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Task Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(snapshot.data['data']['title']),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(snapshot.data['data']['description']),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(snapshot.data['info']),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }
}
