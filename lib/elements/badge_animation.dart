import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';

class BadgeAnimation extends StatefulWidget {
  final String text;
  final Duration duration;

  const BadgeAnimation({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: addedPointsDuration),
  });

  @override
  _BadgeAnimationState createState() => _BadgeAnimationState();
}

class _BadgeAnimationState extends State<BadgeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _shineAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: pointsBadgeMT,
          left: pointsBadgeML(MediaQuery.of(context).size),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: successColor.withOpacity(pointsBadgeOpacity),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.4),
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: Alignment(-_shineAnimation.value, -1.0),
                    end: Alignment(_shineAnimation.value, 1.0),
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor(context),
                    fontSize: badgeTextSize,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
