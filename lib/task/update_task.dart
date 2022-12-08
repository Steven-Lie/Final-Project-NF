import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/task_provider.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.label,
      required this.milestone,
      required this.progress});
  final String? title;
  final String? description;
  final String? status;
  final String? label;
  final String? milestone;
  final String? progress;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  String? _statusValue;
  String? _progressValue;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController milestoneController = TextEditingController();

  @override
  void initState() {
    _statusValue = widget.status;
    _progressValue = widget.progress;
    titleController = TextEditingController(text: widget.title);
    descController = TextEditingController(text: widget.description);
    labelController = TextEditingController(text: widget.label);
    milestoneController = TextEditingController(text: widget.milestone);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void updateTask() async {
      try {
        var response = await put(
            Uri.parse(
                'https://api2.sib3.nurulfikri.com/api/workspace/task/${taskProvider.id}'),
            headers: {
              'Authorization': 'Bearer ${userProvider.accessToken}'
            },
            body: {
              "title": titleController.text,
              "description": descController.text,
              "status": _statusValue,
              "label": labelController.text,
              "milestone": milestoneController.text,
              "progress": _progressValue,
            });

        var responseBody = jsonDecode(response.body);
        sMessenger.showSnackBar(
          SnackBar(
            content: Text(responseBody['info']),
          ),
        );

        if (responseBody['code'] == "00") {
          taskProvider.setTitle(responseBody['data']['title']);
          taskProvider.setDescription(responseBody['data']['description']);
          taskProvider.setStatus(responseBody['data']['status']);
          taskProvider.setLabel(responseBody['data']['label']);
          taskProvider.setMilestone(responseBody['data']['milestone']);
          taskProvider.setProgress(responseBody['data']['progress']);
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
          'Task',
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
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
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
                    helperText: "This is the name of your task",
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: descController,
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
                        "Get your members on board with a few words about the task",
                    alignLabelWithHint: true,
                  ),
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text("Status"),
                const SizedBox(
                  height: 8.0,
                ),
                RadioListTile(
                  value: "1",
                  groupValue: _statusValue,
                  onChanged: (value) => setState(() {
                    _statusValue = value;
                  }),
                  title: const Text('Active'),
                ),
                RadioListTile(
                  value: "2",
                  groupValue: _statusValue,
                  onChanged: (value) => setState(() {
                    _statusValue = value;
                  }),
                  title: const Text('Non-Active'),
                ),
                TextFormField(
                  controller: labelController,
                  decoration: InputDecoration(
                    labelText: 'Label',
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
                TextFormField(
                  controller: milestoneController,
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
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text("Progress"),
                const SizedBox(
                  height: 8.0,
                ),
                RadioListTile(
                  value: "OPEN",
                  groupValue: _progressValue,
                  onChanged: (value) => setState(() {
                    _progressValue = value;
                  }),
                  title: const Text('Open'),
                ),
                RadioListTile(
                  value: "INPROGRESS",
                  groupValue: _progressValue,
                  onChanged: (value) => setState(() {
                    _progressValue = value;
                  }),
                  title: const Text('In-Progress'),
                ),
                RadioListTile(
                  value: "COMPLETED",
                  groupValue: _progressValue,
                  onChanged: (value) => setState(() {
                    _progressValue = value;
                  }),
                  title: const Text('Completed'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateTask();
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
