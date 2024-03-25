import 'package:custom_research/feature/research/model/research_model.dart';
import 'package:custom_research/feature/research/model/response_model.dart';

sealed class StatisticsState {}

final class StatisticsStateInitialState extends StatisticsState {}

final class StatisticsStateLoadingState extends StatisticsState {}

final class StatisticsStateSubmitLoadingState extends StatisticsState {
  final ResearchModel? research;

  StatisticsStateSubmitLoadingState({this.research});
}

final class StatisticsStateFailureState extends StatisticsState {}

final class StatisticsStateSuccessState extends StatisticsState {
  final List<ResponseModel> responses;

  StatisticsStateSuccessState({required this.responses});
}

final class StatisticsStateSubmitedState extends StatisticsState {}
