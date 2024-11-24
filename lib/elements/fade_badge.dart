import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';

class FadeBadge extends StatefulWidget {
  final String message;
  final Color color;
  final Duration duration;

  const FadeBadge({
    super.key,
    required this.message,
    this.color = successColor,
    this.duration = const Duration(seconds: successDuration),
  });

  @override
  _FadeBadgeState createState() => _FadeBadgeState();
}

class _FadeBadgeState extends State<FadeBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: MediaQuery.of(context).size.width * 0.2,
      child: AnimatedBuilder(
        animation: _opacity,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Text(
                widget.message,
                style: TextStyle(
                    color: messageColor,
                    fontSize: smallTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
