import 'package:custom_research/feature/research/model/answer_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:custom_research/feature/research/controller/research/research_state.dart';
import 'package:custom_research/feature/research/datasources/research_datasource.dart';

class ResearchController {
  final ResearchDatasource datasource;
  ResearchController({
    required this.datasource,
  });
  final _state = signal<ResearchState>(ResearchStateInitialState());
  ResearchState get state => _state.value;

  List<AnswerModel> userAnswers = [];

  load({required String researchId}) async {
    _state.value = ResearchStateLoadingState();
    _state.value = ResearchStateSuccessState(
        research: await datasource.loadResearch(researchId));
  }

  addAnswer(AnswerModel answer) {
    if (userAnswers.indexWhere(
          (e) => e.question == answer.question,
        ) ==
        -1) {
      userAnswers.add(answer);
    } else {
      userAnswers[userAnswers.indexWhere(
        (e) => e.question == answer.question,
      )] = answer;
    }
  }

  submit({required String researchId}) async {
    _state.value = ResearchStateSubmitLoadingState(
        research: (_state.value as ResearchStateSuccessState).research);
    final registered = await datasource.submitResearch(researchId, userAnswers);

    if (registered) {
      _state.value = ResearchStateSubmitedState();
    } else {
      _state.value = ResearchStateFailureState();
    }
  }
}
