//After logged in, the home screen should appear and not the login screen. For that we need to
//save that instance of user details. Becoz when the app is closed without signing out, and again opened, the home
//screen should appear.

//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String UserLoggedInKey = "USERLOGGEDINKEY";
//initially giving a value to UserLoggedInKey, then when a user logs in, saves user loggedin details to that variable.
  static saveUserLoggedInDetails({@required bool isLoggedIn}) async { //Named optional parameters can't start with an underscore.
    SharedPreferences prefs = await SharedPreferences.getInstance(); //this is Future<SharedPreferences>, therefore should use await.
    prefs.setBool(UserLoggedInKey, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(UserLoggedInKey);
  }
}