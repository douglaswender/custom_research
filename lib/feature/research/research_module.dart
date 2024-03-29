import 'package:custom_research/core/extensions/route_manager_ext.dart';
import 'package:custom_research/feature/research/controller/statistics/statistics_controller.dart';
import 'package:custom_research/feature/research/datasources/research_datasource.dart';
import 'package:custom_research/feature/research/pages/statistic_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'controller/research/research_controller.dart';
import './research_page.dart';

class ResearchModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ResearchDatasource.new);
    i.addLazySingleton(ResearchController.new);
    i.addLazySingleton(StatisticsController.new);
  }

  @override
  void routes(r) {
    r.appChild('/:id',
        child: (context) => ResearchPage(
              id: r.args.params['id'],
            ));
    r.appChild(
      '/:id/statistics',
      child: (context) => StatisticsPage(
        id: r.args.params['id'],
      ),
    );
  }
}
