// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_reponses/Utils/constants.dart';
import 'package:questions_reponses/cubit/question_cubit.dart';
import 'package:questions_reponses/data/model/question.dart';
import 'package:questions_reponses/data/provider/questions_firebase_provider.dart';
import 'package:questions_reponses/views/screen/add_question_view.dart';
import 'package:questions_reponses/views/widget/error_view.dart';
import 'package:questions_reponses/views/widget/loading_view.dart';
import 'package:questions_reponses/views/screen/questions_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuestionsFirebaseProvider _questionsFirebaseProvider =
      new QuestionsFirebaseProvider();
  late String dropdownValue;
  late bool gameOn;
  @override
  void initState() {
    dropdownValue = 'Général';
    gameOn = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (gameOn)
          ? goToGame()
          : SingleChildScrollView(
              child: Container(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image(
                        image: AssetImage("images/homeImage.png"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    FutureBuilder<List<String>>(
                        future: _questionsFirebaseProvider.getAllTheme(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.hasError) {
                            return ErrorView(error: snapshot.error.toString());
                          }
                          if (snapshot.hasData) {
                            List<String> theme = [Constants.general_theme];
                            theme.addAll(snapshot.data!);
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                underline:
                                    Container(height: 2, color: Colors.white),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                isExpanded: true,
                                items: theme
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return Loading();
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  gameOn = true;
                                });
                              },
                              child: Text("Jouer")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddQuestion()));
                              },
                              child: Text("Ajouter")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget goToGame() {
    return FutureBuilder(
        future: _questionsFirebaseProvider.getQuestionsFromTheme(dropdownValue),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return Provider<QuestionCubit>(
                create: (_) => QuestionCubit(),
                child: QuestionsView(questions: snapshot.data! as List<Question>),
              );
          }
          return Loading();
        });
  }
}
