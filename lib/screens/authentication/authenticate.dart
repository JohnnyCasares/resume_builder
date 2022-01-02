import 'package:flutter/material.dart';

//This widget is gonna be a toggle to change between register screen and sign in screen
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('AUTHENTICATE'),
    );
  }
}
