import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/provider/task_provider.dart';
import 'package:project_management/task/create_task.dart';
import 'package:project_management/task/detail_task.dart';
import 'package:project_management/workspace/invite_remove_team.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:project_management/workspace/update_workspace.dart';
import 'package:project_management/workspace/workspace.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

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

    List<dynamic> openTask = [];
    List<dynamic> inProgressTask = [];
    List<dynamic> completedTask = [];

    Future<dynamic> getWorkspace() async {
      try {
        var response = await get(
          Uri.parse(
              'https://api2.sib3.nurulfikri.com/api/workspace/${workspaceProvider.workspaceId}'),
          headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
        );
        return jsonDecode(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

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
                navigator
                    .push(
                      MaterialPageRoute(
                        builder: (context) => UpdateWorkspace(
                          workspaceName: workspaceProvider.workspaceName,
                          workspaceDescription:
                              workspaceProvider.workspaceDescription,
                          workspaceVisibility:
                              workspaceProvider.workspaceVisibility,
                        ),
                      ),
                    )
                    .then(
                      (value) => setState(() {}),
                    );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsPadding: const EdgeInsets.only(bottom: 20.0),
                    title: const Text("Delete This Workspace?"),
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
                        onPressed: () => deleteWorkspace(),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => const InviteRemoveTeam(),
                  ),
                );
              },
              icon: const Icon(Icons.person_add)),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: getWorkspace(),
        builder: (context, snapshot) {
          openTask.clear();
          inProgressTask.clear();
          completedTask.clear();
          if (snapshot.hasData) {
            if (snapshot.data['code'] == 200) {
              for (var task in snapshot.data['data']['tasks']) {
                if (task['progress'] == "OPEN") {
                  openTask.add(task);
                } else if (task['progress'] == "INPROGRESS") {
                  inProgressTask.add(task);
                } else {
                  completedTask.add(task);
                }
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFF4CD336),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                        child: Text(
                          'OPEN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Timeline1(
                      color: const Color(0xFF4CD336),
                      data: openTask,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFFD964C),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                        child: Text(
                          'IN PROGRESS',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Timeline1(
                      color: const Color(0xFFFD964C),
                      data: inProgressTask,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0XFF4C53FF),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                        child: Text(
                          'COMPLETED',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Timeline1(
                      color: const Color(0XFF4C53FF),
                      data: inProgressTask,
                    ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigator
              .push(
                MaterialPageRoute(
                  builder: (context) => CreateTask(),
                ),
              )
              .then((value) => setState(() {}));
        },
        label: const Text('Task'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class Timeline1 extends StatefulWidget {
  const Timeline1({
    Key? key,
    required this.color,
    required this.data,
  }) : super(key: key);
  final Color color;
  final List<dynamic> data;

  @override
  State<Timeline1> createState() => _Timeline1State();
}

class _Timeline1State extends State<Timeline1> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: widget.color,
        connectorTheme: const ConnectorThemeData(
          thickness: 3.0,
        ),
      ),
      builder: TimelineTileBuilder.connectedFromStyle(
        connectionDirection: ConnectionDirection.before,
        lastConnectorStyle: ConnectorStyle.transparent,
        connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
        indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
        itemCount: widget.data.length,
        contentsBuilder: (context, index) => InkWell(
          onTap: () {
            taskProvider.setTaskId(widget.data[index]['id']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailTask(),
              ),
            ).then((value) => setState(() {}));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.data[index]['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
