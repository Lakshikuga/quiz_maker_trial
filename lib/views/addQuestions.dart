import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  uploadQuestionData() async{
    if(_formKey.currentState.validate()){
      //setState() recreates the screen with UPDATED DATA in which we are, ACCORDING TO THE CURRENT CONTEXT.
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
      await databaseService.addQuestionData(questionMap, widget.quizId)
          .then((value){
            setState(() {
              _isLoading = false;
            });
            //We won't navigate to another screen, we want to be on the same screen.
            //Because "Add Quiz" btn will upload the question to firebase. While the screen only closes when the
          //"Submit" btn is clicked.
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title :appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body : _isLoading ? Container(
        child : Center(
          child: CircularProgressIndicator(),
        ),
      ) : Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:24),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter the question" : null,
                  decoration: InputDecoration(
                    hintText: "Question",
                  ),
                  onChanged: (val){
                    question = val;
                  },
                ),
                SizedBox(height:6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter the Option 1" : null,
                  decoration: InputDecoration(
                    hintText: "Option 1 (Correct Answer)",
                  ),
                  onChanged: (val){
                    option1 = val;
                  },
                ),
                SizedBox(height:6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter the Option 2" : null,
                  decoration: InputDecoration(
                    hintText: "Option 2",
                  ),
                  onChanged: (val){
                    option2 = val;
                  },
                ),
                SizedBox(height:6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter the Option 3" : null,
                  decoration: InputDecoration(
                    hintText: "Option 3",
                  ),
                  onChanged: (val){
                    option3 = val;
                  },
                ),
                SizedBox(height:6),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter the Option 4" : null,
                  decoration: InputDecoration(
                    hintText: "Option 4",
                  ),
                  onChanged: (val){
                    option4 = val;
                  },
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        //TODO
                        Navigator.pop(context); //this closes the current screen.
                      },
                      child: blueButton(
                        context: context,
                        label :"Submit",
                        buttonWidth: MediaQuery.of(context).size.width / 2 -36,
                        //36 is how? 24 + THE DISTANCE BETWEEN THE TWO BUTTON IS 12.
                      ),
                    ),
                    SizedBox(width:24),
                    GestureDetector(
                      onTap: (){
                        //TODO
                        uploadQuestionData();
                      },
                      child: blueButton(
                        context: context,
                        label : "Add Question",
                        buttonWidth: MediaQuery.of(context).size.width / 2 -36,
                        //36 is how? 24 + THE DISTANCE BETWEEN THE TWO BUTTON IS 12.
                      ),
                    )
                  ],
                ),
                SizedBox(height: 60,),
              ],
            )
          ),
        ),
      )
    );
  }
}

