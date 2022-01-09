import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});

  //collection reference
  final CollectionReference resumeCollection =
      FirebaseFirestore.instance.collection('resume');

  Future updateUserData(String name, int phone, String email, String summary,
      String workExperience) async {
    return await resumeCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'summary': summary,
      'work experience': workExperience,
    });
  }

  //get resume stream
  Stream<QuerySnapshot> get resume {
    return resumeCollection.snapshots();
  }
}
