import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_builder/services/auth.dart';
import 'package:resume_builder/shared/textInputModel.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Use scaffold to have basic structure of the screen.
    //Might change to just Container if I dont use the safeSpace
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/white.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Resume Builder',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'BodoniModa',
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BodoniModa',
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Forms to add username and Password
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        //Username Text field
                        TextFormField(
                          decoration: textInputDecoration('Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              //email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Password Text Field
                        TextFormField(
                          decoration: textInputDecoration('Password'),
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              //password = val;
                            });
                          },
                        ),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  //ADD BUTTONS FOR SIGN UP AND GOOGLE SIGN UP
                  ElevatedButton(onPressed: () {}, child: Text('Register')),
                ],
              )),
        ));
  }
}
