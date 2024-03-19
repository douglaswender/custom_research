import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_research/feature/research/model/answer_model.dart';
import 'package:custom_research/feature/research/model/research_model.dart';
import 'package:custom_research/feature/research/model/response_model.dart';

class ResearchDatasource {
  final researchsCollection =
      FirebaseFirestore.instance.collection('researchs');
  final answersCollection = FirebaseFirestore.instance.collection('answers');
  final statisticsCollection =
      FirebaseFirestore.instance.collection('statistics');

  Future<ResearchModel?> loadResearch(String id) async {
    try {
      return await researchsCollection.doc(id).get().then(
            (value) => ResearchModel.fromMap(
              value.data() ?? {},
            ),
          );
    } catch (e) {
      return null;
    }
  }

  Future<bool> submitResearch(String id, List<AnswerModel> answers) async {
    try {
      final document = await answersCollection.doc(id).get();

      if (!document.exists) {
        await answersCollection.doc(id).set({
          'id': id,
          'answers': answers.map((e) => ResponseModel.fromAnswer(e).toMap()),
        });
      } else {
        List<ResponseModel> currentAnswers =
            (document.data()!['answers'] as List)
                .map((e) => ResponseModel.fromMap(e))
                .toList();

        for (final answer in answers) {
          final index = currentAnswers
              .indexWhere((element) => element.question == answer.question);

          currentAnswers[index].responses.addAll(answer.options);
          if (answer.descriptiveAnswer != null) {
            currentAnswers[index]
                .descriptiveAnswer
                .add(answer.descriptiveAnswer!);
          }
        }
        await answersCollection.doc(id).set({
          'id': id,
          'answers': currentAnswers.map((e) => e.toMap()),
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
