import 'package:flutter/material.dart';
import 'package:project_management/login.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
