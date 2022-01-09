import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/screens/home/resume_profile.dart';
import 'package:resume_builder/services/auth.dart';
import 'package:resume_builder/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DataBaseService().resume,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Resume Builder'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            IconButton(
              icon: Icon(Icons.logout),
              // label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
                //await _auth.signOutFromGoogle();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Johnny Casares',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'BodoniModa',
                          fontWeight: FontWeight.bold),
                    ),
                    //add edit button
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('786 655 2968'),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Text('johnny.casares.7@gmail.com'),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Text('Miami, Fl')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Divider(
                  color: Colors.black54,
                  thickness: 1.5,
                  height: 30,
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BodoniModa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'dfgdfg\ndfsfs\nfsdfds\nihigi',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              //Work Experience
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Work Experience',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BodoniModa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'dfgdfg\ndfsfs\nfsdfds\nihigi',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.linkedin,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.github,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
