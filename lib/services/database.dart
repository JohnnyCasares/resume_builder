import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String? header, String? summary) async {
    return await brewCollection.doc(uid).set({
      'header': header,
      'summary': summary,
    });
  }
}
