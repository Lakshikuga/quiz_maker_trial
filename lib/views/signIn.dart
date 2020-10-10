import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/services/auth.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:flutter_quiz_maker_app/views/signUp.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  //to show something to the user while the backend of the app verifies login details, a loading mode is shown without leaving the screen empty.
  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      //whenever the user clicks and signIn and we are able to validate him, we set the state.
      setState(() {
        _isLoading = true;
      });

      //we want the user to go to home screen only if the user is able to signIn and not when the if the below function returns a value.
      //because the value may be null also.
      // we are checking whether the returned userId is null or not.
      //Therefore using then().
      await authService.signInEmaiLAndPass(email, password).then((val) {
        //the val is returned by the signInEmailAndPass function.
        if (val != null) {
          //when user details are verified, we set state again.
          setState(() {
            _isLoading = false;
          });
          //we use pushReplacement because we do not want to go back to the previous screen. The screens get replaced disabling the back option.
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
        //resizeToAvoidBottomInset: false, //to avoid overflow of pixels when the keyboard is open.
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
                          //SizedBox(height : 190,),
                          Spacer(flex: 1),
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
                              obscureText: true, //to make text invisible.
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
                              onTap: () {
                                signIn();
                              },
                              child: blueButton(
                                  context : context,
                                  label : "Sign In",
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: TextStyle(fontSize: 15.5)),
                              GestureDetector(
                                  onTap: () {
                                    widget.toggle;
                                   /* Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()
                                        ));*/
                                  },
                                  child: Text(" Sign Up",
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
