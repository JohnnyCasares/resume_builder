import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_builder/services/auth.dart';
import 'package:resume_builder/shared/loading.dart';
import 'package:resume_builder/shared/textInputModel.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  SignIn({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<SignIn> {
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
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/assets/images/white.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 150, horizontal: 45),
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
                                  color: Colors.black),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Sign In',
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
                                //Username Text field
                                TextFormField(
                                  decoration: textInputDecoration('Email'),
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    if (mounted) {
                                      setState(() {
                                        email = val;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
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
                          //Button to Login/Sign in
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _authService
                                      .signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'please provide valid email';
                                    });
                                  }
                                }
                              },
                              child: Text('Login')),
                          const SizedBox(height: 10),

                          //Button toggle Register
                          TextButton(
                              onPressed: () {
                                widget.toggleView!();
                              },
                              child: Text('Sign up')),
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
                                onPressed: () {
                                  _authService.signInWithFacebook();
                                },
                                child: const Icon(
                                  FontAwesomeIcons.facebook,
                                ),
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
                      ),
                    )),
              ),
            ));
  }
}
