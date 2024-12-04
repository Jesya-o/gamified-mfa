import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/config.dart';

class FadeBadge extends StatefulWidget {
  final String message;
  final Color color;
  final Duration duration;

  const FadeBadge({
    super.key,
    required this.message,
    this.color = Colors.lightGreen,
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

  double _calculateLeftPosition(BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.message,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double textWidth = textPainter.width;
    final double screenWidth = MediaQuery.of(context).size.width;

    return (screenWidth - textWidth) / 2 - 20;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: _calculateLeftPosition(context),
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
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
