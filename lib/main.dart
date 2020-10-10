import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/authenticate.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:flutter_quiz_maker_app/views/signIn.dart';
//import 'package:flutter_quiz_maker_app/views/signUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedIn ?? false) ? Home() : Authenticate(),//SignIn(), //but if the user loggedin details is not saved in the shared preferences and
      //getUserLoggedInDetails() is called, then _isLoggedIn returns null. To avoid that, we use ?? to check if
      //_isLoggedIn is null.
    );
  }

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async{
    HelperFunctions.getUserLoggedInDetails() //since getUserLoggedInDetails is a Future, we have to use wait.
        .then((value){
          setState(() { //even though we were saving the details from the signIn and signUp screen and the value is obtained from
            //the getUserLoggedInDetails() method and assigned to _isLoggedIn, we are not setting the state, so that we can update the screen with the latest values.
            _isLoggedIn = value;
          });
    });
  }
}
