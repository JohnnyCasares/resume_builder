import 'package:flutter/material.dart';
import 'package:resume_builder/screens/authentication/authenticate.dart';
import 'package:resume_builder/screens/home/home.dart';
import 'package:resume_builder/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
