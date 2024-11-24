import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onNumberTap;
  final VoidCallback onBackspaceTap;

  const NumericKeypad({
    super.key,
    required this.onNumberTap,
    required this.onBackspaceTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index < 9) {
          return ElevatedButton(
            onPressed: () => onNumberTap((index + 1).toString()),
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                  fontSize: headingTextSize, fontWeight: FontWeight.bold),
            ),
          );
        } else if (index == 9) {
          return SizedBox.shrink(); // Placeholder for empty space.
        } else if (index == 10) {
          return ElevatedButton(
            onPressed: () => onNumberTap('0'),
            child: Text(
              '0',
              style: TextStyle(
                  fontSize: headingTextSize, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: onBackspaceTap,
            child: Icon(Icons.backspace, size: headingTextSize),
          );
        }
      },
    );
  }
}
