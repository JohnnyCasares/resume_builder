import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/models/resource.dart';
import 'package:resume_builder/models/user.dart';
import 'package:resume_builder/services/database.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  //private final instance of Firebase auth to make calls to the
  //database for sign up and sign in
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //Grab from Firebase User the info we need to use my own User model
  //create a UserModel object based on firebaseUser
  UserModel? _userFromFireBase(User user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream

  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFireBase(user!));
    //these are the same (the one above and the on below)
    //.map((FirebaseUser user) => _userFromFireBase(user));
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
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

//Sign Out for Google
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

//Sign up/in with Facebook
  Future signInWithFacebook() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final FacebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(FacebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
      apiKey: '4kyLAesfkDnA1O5iGBvfyKt8T',
      apiSecretKey: 'NGI7VShZVUqt72mVbBDcVIe0U1RURqhjkxEyFwl18c1WayUcuc',
      redirectURI: 'flutter-twitter-login://',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    try {
      await twitterLogin.login().then((value) async {
        final twitterAuthCredential = TwitterAuthProvider.credential(
            accessToken: value.authToken!, secret: value.authTokenSecret!);

        _auth.signInWithCredential(twitterAuthCredential);
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}
