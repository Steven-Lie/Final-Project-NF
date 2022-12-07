import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/create_workspace.dart';
import 'package:project_management/detail_workspace.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/provider/workspace_provider.dart';
import 'package:project_management/widget/navigation_drawer.dart';
import 'package:provider/provider.dart';

class Workspace extends StatefulWidget {
  const Workspace({super.key});

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final workspaceProvider =
        Provider.of<WorkspaceProvider>(context, listen: false);

    Future<dynamic> allWorkspaceService() async {
      var response = await get(
        Uri.parse('https://api2.sib3.nurulfikri.com/api/workspace'),
        headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
      );

      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 83, 255),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Workspace',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(255, 255, 255, .8),
              ),
              child: TextButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateWorkspace(),
                    ),
                  ).then(
                    (value) => setState(() {}),
                  );
                }),
                child: const Text(
                  'Create +',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.white,
      body: FutureBuilder<dynamic>(
        future: allWorkspaceService(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['code'] == 200) {
              return ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          workspaceProvider
                              .setId(snapshot.data['data'][index]['id']);
                          workspaceProvider
                              .setName(snapshot.data['data'][index]['name']);
                          workspaceProvider.setDescription(
                              snapshot.data['data'][index]['description']);
                          workspaceProvider.setVisibility(
                              snapshot.data['data'][index]['visibility']);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailWorkspace(),
                            ),
                          ).then(
                            (value) => setState(() {}),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(76, 83, 255, 1)),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Text(
                                          snapshot.data['data'][index]['name'],
                                          style: TextStyle(
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = const Color.fromRGBO(
                                                  76, 83, 255, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        Text(
                                          snapshot.data['data'][index]['name'],
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data['data'][index]
                                          ['description'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, .5),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.blue.shade800,
                                        ),
                                        Text(
                                          snapshot.data['data'][index]
                                                  ['visibility'] +
                                              ' Visible',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Created at : ${snapshot.data['data'][index]['created_at']}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      "Updated at : ${snapshot.data['data'][index]['updated_at']}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
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
