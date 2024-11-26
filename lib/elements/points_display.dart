import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/util/custom_colors.dart';

class PointsDisplay extends StatelessWidget {
  final int points;
  final int level;
  final bool isInTop10;

  const PointsDisplay({
    super.key,
    required this.points,
    required this.level,
    this.isInTop10 = false,
  });

  @override
  Widget build(BuildContext context) {
    double progress = points / levelUpPoints;
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
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
                    'Points: $points / $levelUpPoints',
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context)
                              .extension<CustomColors>()!
                              .pointsProgressLineColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if (isInTop10) // Conditionally show the badge
        Positioned(
          top: pointsMT - 11,
          right: pointsMR + 25,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? maize
                  : pennRed.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'You are in ',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? oxfordBlue
                          : snow,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Top 10!',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? oxfordBlue
                          : snow,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ]);
  }
}
