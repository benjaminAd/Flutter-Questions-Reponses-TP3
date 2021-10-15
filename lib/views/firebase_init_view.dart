import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questions_reponses/cubit/question_cubit.dart';
import 'package:questions_reponses/views/error_view.dart';
import 'package:questions_reponses/views/loading_view.dart';

import 'home.dart';

class FirebaseInit extends StatelessWidget {
  FirebaseInit({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Questions réponses',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorView(error: snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocProvider(
                create: (_) => QuestionCubit(),
                child: HomePage(),
              );
            }
            return Loading();
          },
        ));
  }
}
