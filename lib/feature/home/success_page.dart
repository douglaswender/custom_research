import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/widgets/app_scaffold_widget.dart';
import 'package:custom_research/shared/widgets/bouncing_widget.dart';
import 'package:custom_research/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SizedBox(
        height: 250,
        child: Column(
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
            Text(
              'Parabéns, sua resposta foi enviada com sucesso!',
              style: kTitleTextStyle.copyWith(color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonWidget(
              text: 'Ir para o início!',
              onPressed: () => Modular.to.pushReplacementNamed('/'),
            )
          ],
        ),
      ),
    );
  }
}
