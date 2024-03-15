import 'package:custom_research/core/constants/config.dart';
import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/controller/app_menu_controller.dart';
import 'package:custom_research/shared/widgets/header_widget.dart';
import 'package:custom_research/shared/widgets/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final menuController = Modular.get<AppMenuController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menuController.setIndexByRoute(Modular.args.uri.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: SideMenuWidget(),
      backgroundColor: kDarkBlackColor,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              HeaderWidget(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  constraints: const BoxConstraints(maxWidth: kMaxWidth),
                  child: widget.child,
                ),
              ),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Desenvolvido por Douglas Wender'),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
