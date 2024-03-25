import 'package:custom_research/feature/research/controller/statistics/statistics_state.dart';
import 'package:custom_research/feature/research/model/answer_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:custom_research/feature/research/datasources/research_datasource.dart';

class StatisticsController {
  final ResearchDatasource datasource;
  StatisticsController({
    required this.datasource,
  });
  final _state = signal<StatisticsState>(StatisticsStateInitialState());
  StatisticsState get state => _state.value;

  List<AnswerModel> userAnswers = [];

  load({required String researchId}) async {
    _state.value = StatisticsStateLoadingState();
    _state.value = StatisticsStateSuccessState(
        responses: await datasource.loadStatistics(researchId));
  }
}
