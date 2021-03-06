import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_builder/services/auth.dart';
import 'package:resume_builder/shared/loading.dart';
import 'package:resume_builder/shared/textInputModel.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
//Textfield State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //Use scaffold to have basic structure of the screen.
    //Might change to just Container if I dont use the safeSpace
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 150, horizontal: 45),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/assets/images/background.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Resume Builder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'BodoniModa',
                                color: Colors.white),
                          ),
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'BodoniModa',
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Forms to add username and Password
                        Form(
                            key: _formKey,
                            child: Column(children: [
                              //Username Text field
                              TextFormField(
                                decoration: textInputDecoration('Email'),
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 30,
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
                                    password = val;
                                  });
                                },
                              ),
                            ])),
                        const SizedBox(
                          height: 20,
                        ),
                        //Button to Register
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'please provide valid email';
                                  });
                                }
                              }
                            },
                            child: Text('Register')),
                        const SizedBox(height: 10),

                        //Button toggle sign in
                        TextButton(
                            onPressed: () {
                              widget.toggleView!();
                            },
                            child: Text('Sign in')),
                        const SizedBox(
                          height: 20,
                        ),

                        //ADD BUTTONS FOR SIGN UP AND GOOGLE SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                _authService.signInwithGoogle();
                              },
                              child: const Icon(
                                FontAwesomeIcons.google,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            FloatingActionButton(
                              child: const Icon(
                                FontAwesomeIcons.facebook,
                              ),
                              onPressed: () async {
                                _authService.signInWithFacebook();
                              },
                            ),
                            // const SizedBox(
                            //   width: 20,
                            // ),
                            // FloatingActionButton(
                            //   onPressed: () {
                            //     _authService.signInWithTwitter();
                            //   },
                            //   child: const Icon(
                            //     FontAwesomeIcons.twitter,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    )),
              ),
            ));
  }
}
