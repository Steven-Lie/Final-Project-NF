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
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
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
                    FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color(0xFF4CD336),
                        connectorTheme: const ConnectorThemeData(
                          thickness: 3.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connectedFromStyle(
                        connectionDirection: ConnectionDirection.before,
                        lastConnectorStyle: ConnectorStyle.transparent,
                        connectorStyleBuilder: (context, index) =>
                            ConnectorStyle.solidLine,
                        indicatorStyleBuilder: (context, index) =>
                            IndicatorStyle.dot,
                        itemCount: openTask.length,
                        contentsBuilder: (context, index) => InkWell(
                          onTap: () {
                            taskProvider.setTaskId(openTask[index]['id']);
                            taskProvider.setTitle(openTask[index]['title']);
                            taskProvider
                                .setDescription(openTask[index]['description']);
                            taskProvider.setStatus(openTask[index]['status']);
                            taskProvider.setLabel(openTask[index]['label']);
                            taskProvider
                                .setMilestone(openTask[index]['milestone']);
                            taskProvider
                                .setProgress(openTask[index]['progress']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailTask(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  openTask[index]['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                    FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color(0xFFFD964C),
                        connectorTheme: const ConnectorThemeData(
                          thickness: 3.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connectedFromStyle(
                        connectionDirection: ConnectionDirection.before,
                        lastConnectorStyle: ConnectorStyle.transparent,
                        connectorStyleBuilder: (context, index) =>
                            ConnectorStyle.solidLine,
                        indicatorStyleBuilder: (context, index) =>
                            IndicatorStyle.dot,
                        itemCount: inProgressTask.length,
                        contentsBuilder: (context, index) => InkWell(
                          onTap: () {
                            taskProvider.setTaskId(inProgressTask[index]['id']);
                            taskProvider
                                .setTitle(inProgressTask[index]['title']);
                            taskProvider.setDescription(
                                inProgressTask[index]['description']);
                            taskProvider
                                .setStatus(inProgressTask[index]['status']);
                            taskProvider
                                .setLabel(inProgressTask[index]['label']);
                            taskProvider.setMilestone(
                                inProgressTask[index]['milestone']);
                            taskProvider
                                .setProgress(inProgressTask[index]['progress']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailTask(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  inProgressTask[index]['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                    FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color(0XFF4C53FF),
                        connectorTheme: const ConnectorThemeData(
                          thickness: 3.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connectedFromStyle(
                        connectionDirection: ConnectionDirection.before,
                        lastConnectorStyle: ConnectorStyle.transparent,
                        connectorStyleBuilder: (context, index) =>
                            ConnectorStyle.solidLine,
                        indicatorStyleBuilder: (context, index) =>
                            IndicatorStyle.dot,
                        itemCount: completedTask.length,
                        contentsBuilder: (context, index) => InkWell(
                          onTap: () {
                            taskProvider.setTaskId(completedTask[index]['id']);
                            taskProvider
                                .setTitle(completedTask[index]['title']);
                            taskProvider.setDescription(
                                completedTask[index]['description']);
                            taskProvider
                                .setStatus(completedTask[index]['status']);
                            taskProvider
                                .setLabel(completedTask[index]['label']);
                            taskProvider.setMilestone(
                                completedTask[index]['milestone']);
                            taskProvider
                                .setProgress(completedTask[index]['progress']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailTask(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  completedTask[index]['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
