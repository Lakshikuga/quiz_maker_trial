import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/addQuestions.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  CreateQuiz() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      //this saves an alphanumeric random key generated when the btn is clicked. This is generated by a dependency.
      quizId = randomAlphaNumeric(12); //generates a random alphanumeric key.
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription
      };
      //once that data is uploaded. This function will not return anything because the func is void.
      //await is used because uploading takes time.
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      //form elements arranged vertically.
                      children: [
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter Image Url" : null,
                          decoration:
                              InputDecoration(hintText: "Quiz Image Url"),
                          onChanged: (val) {
                            //TODO
                            //saving the state.
                            quizImageUrl = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter Quiz title" : null,
                          decoration: InputDecoration(hintText: "Quiz Title"),
                          onChanged: (val) {
                            //TODO
                            //saving the state.
                            quizTitle = val;
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter quiz description" : null,
                          decoration:
                              InputDecoration(hintText: "Quiz Description"),
                          onChanged: (val) {
                            //TODO
                            //saving the state.
                            quizDescription = val;
                          },
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              CreateQuiz();
                            },
                            //error will be shown because we have changed it from a normal argument to a named parameter.
                            //named parameter is within {}.
                            child: blueButton(
                                context : context,
                                label : "Create Quiz",
                            )),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    )),
              ),
            ),
    );
  }
}

//To format, use the command: flutter format .