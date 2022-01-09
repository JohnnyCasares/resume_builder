import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumeProfile extends StatefulWidget {
  const ResumeProfile({Key? key}) : super(key: key);

  @override
  _ResumeProfileState createState() => _ResumeProfileState();
}

class _ResumeProfileState extends State<ResumeProfile> {
  @override
  Widget build(BuildContext context) {
    final resume = Provider.of<QuerySnapshot>(context);

    return Container();
  }
}
