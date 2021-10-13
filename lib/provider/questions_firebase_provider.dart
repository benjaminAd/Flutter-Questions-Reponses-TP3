import 'package:questions_reponses/model/question.dart';
import 'package:questions_reponses/repositories/questions_repositories.dart';

class QuestionsFirebaseProvider {
  final QuestionsRepository _repository = new QuestionsRepository();

  Future<List<Question>> getAllQuestions() async {
    return await _repository.getAllQuestions().then(
        (value) => value.docs.map((e) => Question.toJson(e.data())).toList());
  }
}
