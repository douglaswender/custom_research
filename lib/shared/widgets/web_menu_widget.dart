import 'package:custom_research/core/constants/config.dart';
import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/controller/app_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals_flutter.dart';

class WebMenuWidget extends StatefulWidget {
  const WebMenuWidget({
    super.key,
  });

  @override
  State<WebMenuWidget> createState() => _WebMenuWidgetState();
}

class _WebMenuWidgetState extends State<WebMenuWidget> {
  final _controller = Modular.get<AppMenuController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _controller.menuItems.length,
        (index) => Watch((_) => WebMenuItem(
              text: _controller.menuName(index),
              isActive: index == _controller.getIndex,
              press: () => _controller.setMenuIndex(index),
            )),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  final bool isActive;
  final String text;
  final VoidCallback press;
  const WebMenuItem({
    super.key,
    required this.isActive,
    required this.text,
    required this.press,
  });

  @override
  State<WebMenuItem> createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  @override
  void initState() {
    super.initState();
  }

  Color _borderColor() {
    if (widget.isActive) {
      return kPrimaryColor;
    } else if (!widget.isActive & _isHover) {
      return kPrimaryColor.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isHover = false;
        });
        widget.press();
      },
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: kDefaultDuration,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: _borderColor(), width: 3),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
