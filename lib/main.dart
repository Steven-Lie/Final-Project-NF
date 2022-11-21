import 'package:flutter/material.dart';
import 'package:project_management/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project NF',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color(0XFF4C53FF),
            ),
      ),
      home: const SplashScreen(),
    );
  }
}
