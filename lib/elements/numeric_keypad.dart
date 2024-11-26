import 'package:flutter/material.dart';

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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else if (index == 9) {
          return SizedBox.shrink();
        } else if (index == 10) {
          return ElevatedButton(
            onPressed: () => onNumberTap('0'),
            child: Text(
              '0',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: onBackspaceTap,
            child: Icon(Icons.backspace,
                size: 24, color: Theme.of(context).cardColor),
          );
        }
      },
    );
  }
}
