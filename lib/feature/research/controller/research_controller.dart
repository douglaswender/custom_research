import 'package:signals_flutter/signals_flutter.dart';

import 'package:custom_research/feature/research/controller/research_state.dart';
import 'package:custom_research/feature/research/datasources/research_datasource.dart';

class ResearchController {
  final ResearchDatasource datasource;
  ResearchController({
    required this.datasource,
  });
  final _state = signal<ResearchState>(ResearchStateInitialState());
  ResearchState get state => _state.value;

  load({required String id}) async {
    _state.value = ResearchStateLoadingState();
    _state.value =
        ResearchStateSuccessState(research: await datasource.loadResearch(id));
  }
}
