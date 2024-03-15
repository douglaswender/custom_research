import 'package:custom_research/main_module.dart';
import 'package:custom_research/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(
    module: MainModule(),
    child: const MainWidget(),
  ));
}
