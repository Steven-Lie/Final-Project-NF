import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_management/auth/login.dart';
import 'package:project_management/profile/profile.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/workspace/workspace.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    void logout() async {
      try {
        var response = await post(
          Uri.parse('https://api2.sib3.nurulfikri.com/api/auth/logout'),
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
              builder: (context) => Login(),
            ),
            (route) => false,
          );

          userProvider.setAccessToken("");
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Drawer(
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
              onTap: () {
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Workspace(),
                  ),
                  (route) => false,
                );
              },
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
              onTap: () {
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Profil(),
                    ),
                    (route) => false);
              },
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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsPadding: const EdgeInsets.only(bottom: 20.0),
                    title: const Text("Are you sure to log out?"),
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
                        onPressed: () => logout(),
                        child: const Text("Log out"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
