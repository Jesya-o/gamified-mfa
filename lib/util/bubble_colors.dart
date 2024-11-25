import 'package:flutter/material.dart';

class BubbleColors extends ThemeExtension<BubbleColors> {
  final Color bubbleColor1;
  final Color bubbleColor2;
  final Color bubbleColor3;
  final Color bubbleColor4;
  final Color bubbleColor5;
  final Color bubbleColor6;
  final Color bubbleColor7;
  final Color bubbleColor8;
  final Color bubbleColor9;
  final Color bubbleColor0;

  const BubbleColors({
    required this.bubbleColor1,
    required this.bubbleColor2,
    required this.bubbleColor3,
    required this.bubbleColor4,
    required this.bubbleColor5,
    required this.bubbleColor6,
    required this.bubbleColor7,
    required this.bubbleColor8,
    required this.bubbleColor9,
    required this.bubbleColor0,
  });

  @override
  BubbleColors copyWith({
    Color? bubbleColor1,
    Color? bubbleColor2,
    Color? bubbleColor3,
    Color? bubbleColor4,
    Color? bubbleColor5,
    Color? bubbleColor6,
    Color? bubbleColor7,
    Color? bubbleColor8,
    Color? bubbleColor9,
    Color? bubbleColor0,
  }) {
    return BubbleColors(
      bubbleColor1: bubbleColor1 ?? this.bubbleColor1,
      bubbleColor2: bubbleColor2 ?? this.bubbleColor2,
      bubbleColor3: bubbleColor3 ?? this.bubbleColor3,
      bubbleColor4: bubbleColor4 ?? this.bubbleColor4,
      bubbleColor5: bubbleColor5 ?? this.bubbleColor5,
      bubbleColor6: bubbleColor6 ?? this.bubbleColor6,
      bubbleColor7: bubbleColor7 ?? this.bubbleColor7,
      bubbleColor8: bubbleColor8 ?? this.bubbleColor8,
      bubbleColor9: bubbleColor9 ?? this.bubbleColor9,
      bubbleColor0: bubbleColor0 ?? this.bubbleColor0,
    );
  }

  @override
  BubbleColors lerp(ThemeExtension<BubbleColors>? other, double t) {
    if (other is! BubbleColors) return this;
    return BubbleColors(
      bubbleColor1: Color.lerp(bubbleColor1, other.bubbleColor1, t)!,
      bubbleColor2: Color.lerp(bubbleColor2, other.bubbleColor2, t)!,
      bubbleColor3: Color.lerp(bubbleColor3, other.bubbleColor3, t)!,
      bubbleColor4: Color.lerp(bubbleColor4, other.bubbleColor4, t)!,
      bubbleColor5: Color.lerp(bubbleColor5, other.bubbleColor5, t)!,
      bubbleColor6: Color.lerp(bubbleColor6, other.bubbleColor6, t)!,
      bubbleColor7: Color.lerp(bubbleColor7, other.bubbleColor7, t)!,
      bubbleColor8: Color.lerp(bubbleColor8, other.bubbleColor8, t)!,
      bubbleColor9: Color.lerp(bubbleColor9, other.bubbleColor9, t)!,
      bubbleColor0: Color.lerp(bubbleColor0, other.bubbleColor0, t)!,
    );
  }
}
