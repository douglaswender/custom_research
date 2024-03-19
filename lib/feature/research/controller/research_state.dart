import 'package:custom_research/feature/research/model/research_model.dart';

sealed class ResearchState {}

final class ResearchStateInitialState extends ResearchState {}

final class ResearchStateLoadingState extends ResearchState {}

final class ResearchStateSubmitLoadingState extends ResearchState {
  final ResearchModel? research;

  ResearchStateSubmitLoadingState({this.research});
}

final class ResearchStateFailureState extends ResearchState {}

final class ResearchStateSuccessState extends ResearchState {
  final ResearchModel? research;

  ResearchStateSuccessState({this.research});
}

final class ResearchStateSubmitedState extends ResearchState {}
