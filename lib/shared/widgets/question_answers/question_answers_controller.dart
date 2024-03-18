import 'package:custom_research/feature/research/model/answer_model.dart';

class QuestionAnswersController {
  List<AnswerModel> answers = [];
  bool validated = false;
  String? validate({required AnswerModel answer}) {
    print(answers);
    validated = false;
    final isEmpty = answers
        .firstWhere((element) => element.question == answer.question)
        .options
        .isEmpty;
    if (isEmpty) {
      validated = true;
      return 'A pergunta é obrigatória!';
    } else {
      validated = true;
      return null;
    }
  }
}
