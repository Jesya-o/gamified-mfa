import 'package:flutter/material.dart';

class BadgeAnimation extends StatefulWidget {
  final String text;
  final Duration duration;

  const BadgeAnimation({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _BadgeAnimationState createState() => _BadgeAnimationState();
}

class _BadgeAnimationState extends State<BadgeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.purple,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Gradient background with glow effect
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _colorAnimation.value!,
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _colorAnimation.value!.withOpacity(0.5),
                      blurRadius: 20 * _glowAnimation.value,
                      spreadRadius: 5 * _glowAnimation.value,
                    ),
                  ],
                ),
              ),
              // Badge text with custom styling
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Colors.pink, Colors.orange],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              Positioned(
                top: 10 * _glowAnimation.value,
                left: 10 * _glowAnimation.value,
                child: Icon(
                  Icons.star,
                  color: Colors.yellow.withOpacity(0.8),
                  size: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
