import 'package:flutter/material.dart';
import 'package:resume_builder/screens/authentication/authenticate.dart';
import 'package:resume_builder/screens/home/home.dart';
import 'package:resume_builder/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final ThemeData _themeData = new ThemeData(
    textTheme: TextTheme(),
    fontFamily: 'Bondoni',
    primaryColor: Colors.grey[400],
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.black);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      home: Wrapper(),
    );
  }
}
