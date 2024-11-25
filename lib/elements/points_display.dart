import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/util/custom_colors.dart';

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
          color: Theme.of(context)
              .extension<CustomColors>()
              ?.pointsBoxColor
              .withOpacity(pointsBoxOpacity),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Level: $level',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  'Points: $points',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: pointsEdgeInset),
                SizedBox(
                  width: progressLineWidth,
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: progressLineHeight,
                    backgroundColor: Theme.of(context)
                        .extension<CustomColors>()!
                        .pointsProgressLineBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context)
                        .extension<CustomColors>()!
                        .pointsProgressLineColor),
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
