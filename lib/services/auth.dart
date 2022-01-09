import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/models/resource.dart';
import 'package:resume_builder/models/user.dart';
import 'package:resume_builder/services/database.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  //private final instance of Firebase auth to make calls to the
  //database for sign up and sign in
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //Grab from Firebase User the info we need to use my own User model
  //create a UserModel object based on firebaseUser
  UserModel? _userFromFireBase(User? user) {
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
        .map((User? user) => _userFromFireBase(user));
    //these are the same (the one above and the on below)
    //.map((FirebaseUser user) => _userFromFireBase(user));
  }

  ///////////////////////////////////////////////////////////////////////////
  //sign up with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // User user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: email, password: password) as User;
      User? user = result.user;
      await DataBaseService(uid: user?.uid).updateUserData(
          "Your name here", 0000000000, email, "Summary", 'Work Experience');

      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password) as User;
      return _userFromFireBase(user);
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
      await DataBaseService(uid: googleAuth?.idToken).updateUserData(
          "Your name here",
          0000000000,
          googleUser!.email.toString(),
          "Summary",
          'Work Experience');
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

      await DataBaseService(uid: facebookLoginResult.accessToken?.userId)
          .updateUserData("Your name here", 0000000000, 'example@example.com',
              "Summary", 'Work Experience');
      await FirebaseAuth.instance.signInWithCredential(FacebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<void> signOutFromFaceBook() async {
    await FacebookAuth.i.logOut();
    await _auth.signOut();
  }

//Sign in with Twitter
  // Future<UserModel?> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final twitterLogin = new TwitterLogin(
  //       apiKey: 'J3ZrjNWt0wCn4HtQ0ldhbcFm5',
  //       apiSecretKey: 'poJ4yHDNbbwRz6apzr4OzvjikHXOkXQn7G9r7zMuGEHLvIJFGc',
  //       redirectURI:
  //           'https://resume-builder-d1078.firebaseapp.com/__/auth/handler');

  //   /// Forces the user to enter their credentials
  //   /// to ensure the correct users account is authorized.
  //   /// If you want to implement Twitter account switching, set [force_login] to true
  //   /// login(forceLogin: true);

  //   final authResult = await twitterLogin.login();
  //   switch (authResult.status) {
  //     case TwitterLoginStatus.loggedIn:
  //       final twitterAuthProvider = TwitterAuthProvider.credential(
  //           accessToken: authResult.authToken!,
  //           secret: authResult.authTokenSecret!);
  //       final userCredential = await FirebaseAuth.instance
  //           .signInWithCredential(twitterAuthProvider);
  //       return _userFromFireBase(userCredential.user);
  //     case TwitterLoginStatus.cancelledByUser:
  //       // TODO: Handle this case.
  //       break;
  //     case TwitterLoginStatus.cancelledByUser:
  //       throw FirebaseAuthException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: authResult.errorMessage,
  //       );
  //     default:
  //       throw UnimplementedError();
  //   }
  // }
}
