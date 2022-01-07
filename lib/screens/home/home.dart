import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          backgroundColor: Colors.blueGrey[600],
          title: Text('Resume Builder'),
          centerTitle: true,
          actions: [
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
        body: ResumeProfile(),
      ),
    );
  }
}
