import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget child;
  const BouncingWidget({super.key, required this.child});

  @override
  BouncingWidgetState createState() => BouncingWidgetState();
}

class BouncingWidgetState extends State<BouncingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final Animation<double> curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
      reverseCurve: Curves.ease,
    );

    _animation = Tween<double>(begin: 0, end: 25).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
          child: Transform.translate(
            offset: Offset(0, -_animation.value),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
