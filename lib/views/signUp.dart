import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/services/auth.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:flutter_quiz_maker_app/views/signIn.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();

  //here placing an underscore infront of a variable makes it private and thus only accessible within the signUp class.
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      //here validating the current state, whatever we enter in the form when we are are signing up.

      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //convert from container to scaffold, black to white color screen.
        appBar: AppBar(
          title: appBar(context),
          centerTitle:
              true, //Centering the title is the default on iOS. On Android, the AppBar's title defaults to left-aligned, but you can override it by passing centerTitle: true as an argument to the AppBar constructor.
          backgroundColor: Colors.transparent,
          elevation: 0.0, //to not show a gray background in the scaffold.
          brightness: Brightness
              .light, //to show the battery and time on the device when using scaffold.
        ),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: Container(
                      //used when using columns and rows.
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        //when arranging widgets vertically.
                        children: [
                          //SizedBox(height : 50,),
                          Spacer(), //default is flex : 1.
                          TextFormField(
                              validator: (val) {
                                return val.isEmpty ? "Enter Name" : null;
                              },
                              decoration: InputDecoration(
                                hintText: "Name",
                              ),
                              onChanged: (val) {
                                name = val;
                              }),
                          TextFormField(
                              validator: (val) {
                                return val.isEmpty ? "Enter Email ID" : null;
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                              onChanged: (val) {
                                email = val;
                              }),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.isEmpty ? "Enter Password" : null;
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                              onChanged: (val) {
                                password = val;
                              }),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                              // to give the sign up button an onClick property - OnClick Listener.
                              onTap: () {
                                signUp();
                              },
                              child: blueButton(
                                  context : context,
                                  label : "Sign Up",
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                  style: TextStyle(fontSize: 15.5)),
                              GestureDetector(
                                  onTap: () {
                                    widget.toggle;
                                    /*Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()
                                        ));*/
                                  },
                                  child: Text(" Sign In",
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        decoration: TextDecoration.underline,
                                      ))),
                            ],
                          ),

                          SizedBox(height: 80),
                        ],
                      )),
                ),
              ));
  }
}
