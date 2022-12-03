import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/login.dart';
import 'package:project_management/provider/user_provider.dart';
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

    Future<List<dynamic>> allWorkspaceService() async {
      var response = await get(
        Uri.parse('https://api2.sib3.nurulfikri.com/api/workspace'),
        headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];
        return jsonResponse;
      } else {
        throw Exception('Failed to load data');
      }
    }

    log(userProvider.accessToken);

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
        actions: [
          TextButton(
              onPressed: (() {}),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(255, 255, 255, .8),
                ),
                child: TextButton(
                    onPressed: (() {}),
                    child: const Text(
                      'Create +',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    )),
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(76, 83, 255, .83),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Workspace',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: allWorkspaceService(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
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
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        snapshot.data[index]['name'],
                                        style: TextStyle(
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = const Color.fromRGBO(
                                                  76, 83, 255, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter'),
                                      ),
                                      Text(
                                        snapshot.data[index]['name'],
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter'),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data[index]['description'],
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, .5),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter'),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.blue.shade800,
                                      ),
                                      Text(
                                        snapshot.data[index]['visibility'] +
                                            ' Visible',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter'),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Created at : ' +
                                        snapshot.data[index]['created_at'],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter'),
                                  ),
                                  Text(
                                    'Updated at : ' +
                                        snapshot.data[index]['updated_at'],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter'),
                                  ),
                                ],
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
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
          },
        ),
      ),
    );
  }
}
