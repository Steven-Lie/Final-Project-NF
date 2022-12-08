import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:project_management/auth/register.dart';
import 'package:http/http.dart' as http;
import 'package:project_management/workspace/workspace.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    void login() async {
      try {
        var response = await http.post(
          Uri.parse('https://api2.sib3.nurulfikri.com/api/auth/login'),
          body: {
            'email': _emailController.text,
            'password': _passwordController.text,
          },
        );

        var responseBody = jsonDecode(response.body);
        if (responseBody['code'] == "00") {
          userProvider.setAccessToken(responseBody['data']['access_token']);
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Workspace(),
            ),
          );
        } else {
          sMessenger.showSnackBar(
            SnackBar(
              content: Text(responseBody['info']),
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/login.jpg',
                  width: 180,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value?.trim() == '' ? "Don't Empty" : null,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'email',
                          prefixIcon: const Icon(Icons.mail),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF787878),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
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
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value?.trim() == '' ? "Don't Empty" : null,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'password',
                          prefixIcon: const Icon(Icons.key),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF787878),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
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
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not Having An Account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () => navigator.pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF4C53FF),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
