import 'package:flutter/material.dart';
import 'package:resume_builder/screens/authentication/register.dart';

//This widget is gonna be a toggle to change between register screen and sign in screen
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (true) {
      return Register();
    }
  }
}
