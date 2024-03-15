import 'package:custom_research/core/constants/config.dart';
import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/controller/app_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SideMenuWidget extends StatelessWidget {
  SideMenuWidget({super.key});

  final _controller = Modular.get<AppMenuController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kDarkBlackColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 3.5),
                child: Image.asset("assets/icons/logo.png"),
              ),
            ),
            ...List.generate(
              _controller.menuItems.length,
              (index) => DrawerItem(
                isActive: index == _controller.getIndex,
                title: _controller.menuName(index),
                press: () {
                  _controller.setMenuIndex(index);
                  _controller.openOrCloseDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;

  const DrawerItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        selected: isActive,
        selectedTileColor: kPrimaryColor,
        onTap: press,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
