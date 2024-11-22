import 'package:flutter/material.dart';

class PointsDisplay extends StatelessWidget {
  final int points;
  final int level;

  const PointsDisplay({
    super.key,
    required this.points,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Points: $points',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Level: $level',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
