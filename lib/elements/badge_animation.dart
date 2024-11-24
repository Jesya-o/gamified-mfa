import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';

class BadgeAnimation extends StatefulWidget {
  final String text;
  final Duration duration;

  const BadgeAnimation({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: successDuration)
  });

  @override
  _BadgeAnimationState createState() => _BadgeAnimationState();
}

class _BadgeAnimationState extends State<BadgeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Positioned(
          top: 120,
          left: MediaQuery.of(context).size.width / 2 + 60,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                    color: messageColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
