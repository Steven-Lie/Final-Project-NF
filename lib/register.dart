import 'package:flutter/material.dart';
import 'package:project_management/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'images/register.jpg',
                  width: 145,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'first name',
                          prefixIcon: const Icon(Icons.person),
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
                        decoration: InputDecoration(
                          labelText: 'last name',
                          prefixIcon: const Icon(Icons.person),
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
                        decoration: InputDecoration(
                          labelText: 'email',
                          prefixIcon: const Icon(Icons.mail),
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
                        decoration: InputDecoration(
                          labelText: 'phone number',
                          prefixIcon: const Icon(Icons.phone_android),
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
                        decoration: InputDecoration(
                          labelText: 'password',
                          prefixIcon: const Icon(Icons.key),
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
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'password confirmation',
                          prefixIcon: const Icon(Icons.key),
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
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
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
                            'Already have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            ),
                            child: const Text(
                              'Login',
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
