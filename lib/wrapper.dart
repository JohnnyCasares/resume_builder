import 'package:flutter/material.dart';
//The wrapper works alongside with authentication to show a screen depending on whether
//the user is authenticated or not
import 'package:resume_builder/screens/authentication/authenticate.dart';
import 'package:resume_builder/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = null;
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
