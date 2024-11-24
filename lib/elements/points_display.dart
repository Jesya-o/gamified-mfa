import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/theme.dart';

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
    double progress = points / levelUpPoints;

    return Positioned(
      top: pointsMT,
      right: pointsMR,
      child: Container(
        padding: EdgeInsets.all(pointsEdgeInset),
        decoration: BoxDecoration(
          color: pointsBoxColor.withOpacity(pointsBoxOpacity),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Level: $level',
                  style:
                      TextStyle(color: pointsColor, fontSize: regularTextSize),
                ),
                Text(
                  'Points: $points',
                  style: TextStyle(color: pointsColor, fontSize: smallTextSize),
                ),
                SizedBox(height: pointsEdgeInset),
                SizedBox(
                  width: progressLineWidth,
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: progressLineHeight,
                    backgroundColor: pointsProgressLineBackgroundColor,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(pointsProgressLineColor),
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
