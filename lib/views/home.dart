import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/authenticate.dart';
import 'package:flutter_quiz_maker_app/services/auth.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/create_quiz.dart';
import 'package:flutter_quiz_maker_app/views/playQuiz.dart';
import 'package:flutter_quiz_maker_app/views/signIn.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  AuthService authService = new AuthService();

  Widget quizList(){
    return Container(
      margin : EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream : quizStream,
        builder: (context, snapshot){
          return snapshot.data != null ? Expanded(
            child: ListView.builder(
                //scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                return QuizTile(
                  imgUrl: snapshot.data.documents[index].data["quizImgUrl"], //data [key]
                  title: snapshot.data.documents[index].data["quizTitle"],
                  desc: snapshot.data.documents[index].data["quizDesc"],
                  quizId: snapshot.data.documents[index].data["quizId"],
                );
            }),
          ) : Container();
        },
      )
    );
  }


  @override
  void initState() { //whenever the app starts this function is executed.
    databaseService.getQuizData().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
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
       // actions: [
         /* IconButton(
              icon: Icon(
                  Icons.exit_to_app,
                  color:Colors.black87,
              ),
              onPressed: (){
                authService.signOut();
                //setState(() {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => Authenticate()
                  ));
                //});

              }),*/
       // ],
        actions: [
          GestureDetector(
            onTap: (){
              authService.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder : (context) => Authenticate(),
              ));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                child: Icon(Icons.exit_to_app, color: Colors.black,)),
          ),
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {

  final String imgUrl, title, desc, quizId;
  QuizTile({@required this.imgUrl, @required this.title, @required this.desc, @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayQuiz(quizId)
        ));
      },
      child: Container(
        margin : EdgeInsets.only(bottom : 8),
        height: 150,
        child: Stack( //becoz they are one above the other, using Stack.
          children : [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl, width: MediaQuery.of(context).size.width-48, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Colors.black26,
              ),
              //color: Colors.blue, //inserted to check if the height of the text container is also 150.
              alignment : Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color : Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height : 6,),
                  Text(desc, style: TextStyle(color : Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

