import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/user.dart';
//The wrapper works alongside with authentication to show a screen depending on whether
//the user is authenticated or not
import 'package:resume_builder/screens/authentication/authenticate.dart';
import 'package:resume_builder/screens/home/home.dart';

//Wrapper listens to auth changes
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //accesing user data from the provider
    final user = Provider.of<UserModel?>(context);
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
