import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';

class ColorKeypad extends StatelessWidget {
  final Function(String) onColorTap;

  const ColorKeypad({super.key, required this.onColorTap});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.brown,
    ];

    final double bubbleSize = colorBubbleSize;

    final random = Random();
    final List<Offset> positions = [];

    // Generate non-overlapping positions
    Offset getRandomPosition() {
      while (true) {
        final double top = random.nextDouble() * (keypadHeight - bubbleSize);
        final double left = random.nextDouble() * (colorKeypadWidth - bubbleSize);
        final newPosition = Offset(left, top);

        // Check for overlap
        bool hasOverlap = positions.any((existingPosition) {
          return (newPosition - existingPosition).distance < bubbleSize;
        });

        if (!hasOverlap) {
          positions.add(newPosition);
          return newPosition;
        }
      }
    }

    // Create bubbles
    List<Widget> bubbles = List.generate(colors.length, (index) {
      final position = getRandomPosition();
      return Positioned(
        top: position.dy,
        left: position.dx,
        child: GestureDetector(
          onTap: () => onColorTap((index + 1).toString()),
          child: Container(
            width: bubbleSize,
            height: bubbleSize,
            decoration: BoxDecoration(
              color: colors[index],
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    });

    return Stack(
      children: bubbles,
    );
  }
}
