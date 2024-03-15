import 'package:custom_research/core/constants/config.dart';
import 'package:custom_research/core/utils/responsive.dart';
import 'package:custom_research/shared/controller/app_menu_controller.dart';
import 'package:custom_research/shared/widgets/web_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});

  final _controller = Modular.get<AppMenuController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: kMaxWidth,
                maxHeight: Responsive.isMobile(context) ? 64 : double.infinity),
            padding: EdgeInsets.all(
                Responsive.isMobile(context) ? 0 : kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _controller.openOrCloseDrawer();
                        },
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/logo.png",
                        height: Responsive.isDesktop(context) ? 64 : 32,
                      ),
                    ),
                    const Spacer(),
                    if (Responsive.isDesktop(context)) const WebMenuWidget(),
                  ],
                ),
                SizedBox(
                    height:
                        Responsive.isDesktop(context) ? kDefaultPadding : 0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
