import 'package:flutter/material.dart';
import 'package:resume_builder/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(),
    );
  }
}
