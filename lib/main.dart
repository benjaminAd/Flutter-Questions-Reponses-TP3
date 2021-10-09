import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:questions_reponses/cubit/question_cubit.dart';
import 'package:questions_reponses/home.dart';
import 'package:questions_reponses/provider/question_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions réponses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider(
        create: (_) => QuestionCubit(),
        child: HomePage(),
      ),
    );
  }
}
