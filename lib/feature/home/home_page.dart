import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/widgets/app_scaffold_widget.dart';
import 'package:custom_research/shared/widgets/bouncing_widget.dart';
import 'package:custom_research/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BouncingWidget(
            child: Image.asset(
              'assets/icons/logo.png',
              width: 200,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'Vamos iniciar a pesquisa!',
            style: kTitleTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonWidget(
            text: 'Iniciar!',
            onPressed: () => Modular.to
                .pushReplacementNamed('/research/MVUyoIpEEQFsCPKftk01'),
          )
        ],
      ),
    );
  }
}
