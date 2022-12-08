import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/widget/navigation_drawer.dart';
import 'package:provider/provider.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic> getProfile() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        var response = await get(
          Uri.parse('https://api2.sib3.nurulfikri.com/api/profile'),
          headers: {'Authorization': 'Bearer ${userProvider.accessToken}'},
        );
        return jsonDecode(response.body);
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF4C53FF),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.white,
      body: FutureBuilder<dynamic>(
          future: getProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data['code'] == "00") {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: false,
                          initialValue: snapshot.data['data']['user']
                              ['firstname'],
                          decoration: InputDecoration(
                            labelText: 'First name',
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Color(0XFF4C53FF),
                              size: 18,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0XFF4C53FF),
                              fontSize: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: snapshot.data['data']['user']
                              ['lastname'],
                          decoration: InputDecoration(
                            labelText: 'Last name',
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Color(0XFF4C53FF),
                              size: 18,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0XFF4C53FF),
                              fontSize: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: snapshot.data['data']['user']
                              ['username'],
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Color(0XFF4C53FF),
                              size: 18,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0XFF4C53FF),
                              fontSize: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: snapshot.data['data']['user']['email'],
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0XFF4C53FF),
                              size: 18,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0XFF4C53FF),
                              fontSize: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: snapshot.data['data']['user']
                              ['phone_number'],
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            prefixIcon: const Icon(
                              Icons.phone_android,
                              color: Color(0XFF4C53FF),
                              size: 18,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0XFF4C53FF),
                              fontSize: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF4C53FF), width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "images/photo.jpg",
                            height: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: [
                            Text(
                              "Manage your Workspace",
                              style: TextStyle(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              "Manage your Workspace",
                              style: TextStyle(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..color = const Color(0XFF4C53FF),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
          }),
    );
  }
}
