import 'package:flutter_modular/flutter_modular.dart';

extension RouteManagerExt on RouteManager {
  void appChild(
    String name, {
    required ModularChild child,
  }) {
    this.child(
      name,
      child: child,
      transition: TransitionType.noTransition,
    );
  }

  void appModule(
    String name, {
    required Module module,
  }) {
    add(ModuleRoute(
      name,
      module: module,
      transition: TransitionType.noTransition,
    ));
  }
}
