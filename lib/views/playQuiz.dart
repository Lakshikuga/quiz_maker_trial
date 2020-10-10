import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/models/questionModel.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/results.dart';
import 'package:flutter_quiz_maker_app/widgets/play_quiz_widget.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

//variables made global because these have to be accessed by different widgets defined in different classes.
  int total = 0;
  int _correct = 0;
  int _incorrect = 0;
  int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {

  //fetch question data first from firebase.
  DatabaseService databaseService = new DatabaseService();
  //in the getQuestionData method, we are returning all the documents as snapshots. A Future of QuerySnapshots.
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"]; //here the "question" is key in firebase in the key-value pair.

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];

    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    //here we say the option1 is the correct answer, so even when shuffled, the option that has
    //the answer as the option1 will be green.
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column( //why column? to arrange different widgets vertically.
          children: [
            questionSnapshot == null ? Container(
              child : Center(
                child : CircularProgressIndicator(),
              ),
            ) :
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal : 24,),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questionSnapshot.documents.length,
                  itemBuilder: (context, index){
                    return QuizPlayTile(
                      questionModel : getQuestionModelFromDataSnapshot(questionSnapshot.documents[index]),
                      index : index,
                    );
                  },
          ),
              ),
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Results(
                correct : _correct,
                incorrect: _incorrect,
                total : total
              ),
          ));
        },
      ),
    );
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuestionData(widget.quizId).then((val){
      questionSnapshot = val;
      _correct = 0;
      _incorrect = 0;
      _notAttempted = 0; //making it zero again becoz user may close the quiz and attempt again.
      total = questionSnapshot.documents.length;
      print("$total this is total");
      setState(() {

      });
    });
    super.initState();
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  //initially for every tile, we will have to define optionSelected.
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          Text("Q${widget.index+1} ${widget.questionModel.question}", style: TextStyle(color: Colors.black87,
          fontSize:18,),), //using widget to access a property from another class.
          SizedBox(height : 12,),
          //option1
          GestureDetector(
            onTap: (){
              //to make sure the question is unanswered.
              if(!widget.questionModel.answered){
                ///if the answer is correct
                if(widget.questionModel.option1 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                  //if the answer is not the correct answer.
                } else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height : 4,),

          //option2
          GestureDetector(
            onTap: (){
              //to make sure the question is unanswered.
              if(!widget.questionModel.answered){
                ///if the answer is correct
                if(widget.questionModel.option2 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                  //if the answer is not the correct answer.
                } else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height : 4,),

          //option3
          GestureDetector(
            onTap: (){
              //to make sure the question is unanswered.
              if(!widget.questionModel.answered){
                ///if the answer is correct
                if(widget.questionModel.option3 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                  //if the answer is not the correct answer.
                } else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height : 4,),

          //option4
          GestureDetector(
            onTap: (){
              //to make sure the question is unanswered.
              if(!widget.questionModel.answered){
                ///if the answer is correct
                if(widget.questionModel.option4 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                 _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                  //if the answer is not the correct answer.
                } else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20,)
        ],
      )
    );
  }
}

