import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color successColor;
  final Color pointsBoxColor;
  final Color pointsProgressLineColor;
  final Color pointsProgressLineBackgroundColor;

  const CustomColors({
    required this.successColor,
    required this.pointsBoxColor,
    required this.pointsProgressLineColor,
    required this.pointsProgressLineBackgroundColor,
  });

  @override
  CustomColors copyWith({
    Color? successColor,
    Color? pointsBoxColor,
    Color? pointsProgressLineColor,
    Color? pointsProgressLineBackgroundColor,
  }) {
    return CustomColors(
      successColor: successColor ?? this.successColor,
      pointsBoxColor: pointsBoxColor ?? this.pointsBoxColor,
      pointsProgressLineColor:
          pointsProgressLineColor ?? this.pointsProgressLineColor,
      pointsProgressLineBackgroundColor: pointsProgressLineBackgroundColor ??
          this.pointsProgressLineBackgroundColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      successColor: Color.lerp(successColor, other.successColor, t)!,
      pointsBoxColor: Color.lerp(pointsBoxColor, other.pointsBoxColor, t)!,
      pointsProgressLineColor: Color.lerp(
          pointsProgressLineColor, other.pointsProgressLineColor, t)!,
      pointsProgressLineBackgroundColor: Color.lerp(
          pointsProgressLineBackgroundColor,
          other.pointsProgressLineBackgroundColor,
          t)!,
    );
  }
}
