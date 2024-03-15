import 'package:custom_research/shared/widgets/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals_flutter/signals_flutter.dart';

import './home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: Watch(
          (_) {
            return Text(
              'Clicks: ${controller.count}',
            );
          },
        ),
      ),
    );
  }
}
