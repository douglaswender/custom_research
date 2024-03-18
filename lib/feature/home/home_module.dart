import 'package:custom_research/core/extensions/route_manager_ext.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './home_controller.dart';
import './home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.appChild('/', child: (context) => const HomePage());
  }
}
