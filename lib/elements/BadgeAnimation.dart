import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeAnimation extends StatefulWidget {
  final String text;
  final Duration duration;

  const BadgeAnimation({Key? key, required this.text, this.duration = const Duration(seconds: 2)})
      : super(key: key);

  @override
  _BadgeAnimationState createState() => _BadgeAnimationState();
}

class _BadgeAnimationState extends State<BadgeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
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
          top: 50,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
