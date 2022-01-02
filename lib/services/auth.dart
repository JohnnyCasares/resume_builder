import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/models/user.dart';
import 'package:resume_builder/services/database.dart';

class AuthService {
  //private final instance of Firebase auth to make calls to the
  //database for sign up and sign in
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Grab from Firebase User the info we need to use my own User model
  //create a UserModel object based on firebaseUser
  UserModel? _userFromFireBase(User user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////////
  //sign up with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = _auth.createUserWithEmailAndPassword(
          email: email, password: password) as UserCredential;
      User? user = result.user;
      await DataBaseService(uid: user?.uid)
          .updateUserData('Header here', 'Summary here');
      return _userFromFireBase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = _auth.signInWithEmailAndPassword(
          email: email, password: password) as UserCredential;
      User? user = result.user;
      return _userFromFireBase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out for Email and Password
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//////////////////////////////////////////////////////////////////////
//Sign in with GOOGLE
  Future signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;

      final googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

//Sign Out for Google
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
