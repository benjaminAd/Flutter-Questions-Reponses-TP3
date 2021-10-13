import 'package:questions_reponses/model/question.dart';
import 'package:questions_reponses/repositories/questions_repositories.dart';

class QuestionsFirebaseProvider {
  final QuestionsRepository _repository = new QuestionsRepository();

  Stream<List<Question>> getAllQuestions() {
    return _repository.getAllQuestions().map(
        (list) => list.docs.map((doc) => Question.toJson(doc.data())).toList());
  }
}
