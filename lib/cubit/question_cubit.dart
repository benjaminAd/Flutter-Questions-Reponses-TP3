import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:questions_reponses/model/triplet.dart';
import 'package:questions_reponses/model/question.dart';

class QuestionCubit extends Cubit<Triplet<Question, int, int>> {
  final List<Question> _questions = [
    new Question("Paris est-elle la capitale de la France ?",
        "images/tour-eiffel-paris.jpg", true),
    new Question(
        "Le zèbre possède-t-il des rayures ?",
        "images/cover-r4x3w1000-57e155592330a-pourquoi-le-zebre-est-il-raye.jpg",
        true),
    new Question("Le buffle est-il carnivore ? ",
        "images/b11b597d02_50036097_800px-serengeti-bueffel1.jpg", false),
    new Question("La France est-elle un pays Américain ? ",
        "images/frenchflag.jpg", false),
    new Question("Le développeur s'appelle Benjamin ADOLPHE ",
        "images/1000emote1.png", true)
  ];
  var _nbgoodanswer = 0;
  var _nbquestion = 0;

  QuestionCubit() : super(new Triplet(new Question("", "path", false), 0, 0)) {
    _sendQuestion();
  }

  void resetAll() {
    _nbquestion = 0;
    _nbgoodanswer = 0;
    _sendQuestion();
  }

  void checkAnswer(bool answer, BuildContext context) {
    if (_nbquestion < _questions.length) {
      var flag = (answer == _questions[_nbquestion].correctAnswer);
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text(flag
              ? "Vous avez trouvé une bonne réponse!"
              : "C'est dommage ..."),
          duration: Duration(milliseconds: 500)));
      changeQuestion(flag, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content:
          Text('Vous avez terminé le jeu avec un score de $_nbgoodanswer!'),
          duration: Duration(milliseconds: 500)));
    }
  }

  void changeQuestion(bool flagreceived, BuildContext context) {
    if (flagreceived) {
      _nbgoodanswer += 1;
      _nbquestion += 1;
      if (_nbquestion >= _questions.length) {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: Text(
                'Vous avez terminé le jeu avec un score de $_nbgoodanswer!'),
            duration: Duration(milliseconds: 500)));
      }
      _sendQuestion();
    } else {
      _nbquestion += 1;
      if (_nbquestion >= _questions.length) {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content:
          Text('Vous avez terminé le jeu avec un score de $_nbgoodanswer!'),
          duration: Duration(milliseconds: 500),
        ));
      }
      _sendQuestion();
    }
  }

  void _sendQuestion() {
    if (_nbquestion < _questions.length) {
      emit(new Triplet(_questions[_nbquestion], _nbgoodanswer, _nbquestion));
    } else {
      emit(new Triplet(questions.last, _nbgoodanswer, _nbquestion));
    }
  }

  List<Question> get questions => _questions;

  get nbgoodanswer => _nbgoodanswer;

  get nbquestion => _nbquestion;
}
