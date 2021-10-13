import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:questions_reponses/Utils/constants.dart';
import 'package:questions_reponses/model/question.dart';

class QuestionsRepository {
  var _questionsdb =
      FirebaseFirestore.instance.collection(Constants.questions_reference);

  Stream<QuerySnapshot> getAllQuestions() {
    return _questionsdb.snapshots();
  }
}
