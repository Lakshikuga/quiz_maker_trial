import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
//here we ll use cloud firestore, therefore make multidex enabled in android emulators.

  //this function should not return anything.
  //a structure of key-value pairs is called MAP.
  //We are uploading the data as a map. Map is only what we can upload.
  //We ll upload the Map into the collection directly OR we can provide a document Id and add that map inside of it.
  //So we are going with the second option of passing the document Id
  // (which is created when "Create Quiz" btn is clicked) to the function.
  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection(
            "Quiz") //this is basically creating an instance of firebase and going insode the collection.
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  //Adding questions to a particular quizId
  Future<void> addQuestionData(Map questionData, String quizId) async{
    await Firestore.instance.collection("Quiz")
        .document(quizId).collection("QNA").add(questionData).catchError((e){
          print(e.toString());
    });
  }

  //Retrieving quiz data from firebase.
  //We have two ways in showing the quiz data from firebase.
  //1. We can show it once all data is loaded and it ll be visible.
  //2. We can have a "stream" that is, any data that is updated in the database will be reflected directly on the screen.
  getQuizData() async{
    return await Firestore.instance.collection("Quiz").snapshots();
    //the "snapshots" is a stream of type Querysnapshot (Stream<QuerySnapshot>) which is not a Future, since it takes time to upload data to the
    //screen, we use await.
  }

  getQuestionData(String quizId) async{
    return await Firestore.instance.collection("Quiz")
    .document(quizId).collection("QNA").getDocuments(); //this will get all the documents under the collection "QNA"
  }
}
