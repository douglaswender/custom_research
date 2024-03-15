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
        r.child('/', child: (context) => const HomePage());
    }

}