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
    double progress = points / 50;

    return Positioned(
      top: 50,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Level: $level',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Points: $points',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 100, // Set a fixed width for the progression bar.
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: Colors.white60,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
