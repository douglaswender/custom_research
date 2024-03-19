import 'package:custom_research/core/extensions/route_manager_ext.dart';
import 'package:custom_research/feature/home/home_module.dart';
import 'package:custom_research/feature/research/research_module.dart';
import 'package:custom_research/shared/controller/app_menu_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(() => AppMenuController());
  }

  @override
  void routes(r) {
    r.appModule('/', module: HomeModule());
    r.appModule('/research', module: ResearchModule());
  }
}
