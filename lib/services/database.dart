import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});

  //collection reference
  final CollectionReference resumeCollection =
      FirebaseFirestore.instance.collection('resume');

  Future updateUserData(String name, String summary) async {
    return await resumeCollection.doc(uid).set({
      'name': name,
      'summary': summary,
    });
  }

  //get resume stream
  Stream<QuerySnapshot> get resume {
    return resumeCollection.snapshots();
  }
}
