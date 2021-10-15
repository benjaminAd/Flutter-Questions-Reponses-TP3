// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:questions_reponses/provider/questions_firebase_provider.dart';
import 'package:questions_reponses/views/error_view.dart';
import 'package:questions_reponses/views/loading_view.dart';
import 'package:questions_reponses/views/questions_view.dart';
import '../model/question.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final QuestionsFirebaseProvider _questionsFirebaseProvider =
      new QuestionsFirebaseProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenue dans Question / Réponse",
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image(
              image: AssetImage("images/homeImage.png"),
            ),
          ),

          // FutureBuilder(
          //     future: _questionsFirebaseProvider.getAllQuestions(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return ErrorView(error: snapshot.error.toString());
          //       }
          //       if (snapshot.hasData) {
          //         return QuestionsView(
          //             questions: snapshot.data! as List<Question>);
          //       }
          //       return Loading();
          //     })
        ],
      ),
    ),
    );
  }
}
