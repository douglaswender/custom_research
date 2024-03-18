import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals_flutter.dart';

class AppMenuController {
  final _selectedIndex = signal<int>(0);

  int get getIndex => _selectedIndex.value;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String menuName(index) => menuItems[index]['title'];

  List<Map<String, dynamic>> get menuItems => [
        {
          "title": "Início",
          "route": "/",
          "index": 0,
        },
        {
          "title": "Pesquisa",
          "route": "/research/",
          "index": 1,
        },
      ];

  void openOrCloseDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setIndexByRoute(String route) {
    if (route != '/') {
      route = route.replaceAll('/', '');
      route = '/$route';
    }
    final item = menuItems.firstWhere((e) => e['route'] == route);
    _selectedIndex.value = item['index'];
  }

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
    Modular.to.pushReplacementNamed(menuItems[index]['route']);
  }
}
