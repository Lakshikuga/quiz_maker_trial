import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quiz_maker_app/models/user.dart';

class AuthService {
//there are some dependencies to get from pub.dev - firebase cloud firestore, firebase auth and shared preferences.

  FirebaseAuth _auth = FirebaseAuth.instance;

  //to track an anonymous user using userId
  User _userFromFirebaseUser(FirebaseUser user) {
    //FirebaseUser user is a Firebase class.
    return user != null
        ? User(uid: user.uid)
        : null; //user.uid is the property of FirebaseUser class.
  }

  //AWAIT is we wait for the email and password to be verified....this takes time!
  Future signInEmaiLAndPass(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  //signUp
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser); //this returns the user Id.
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
