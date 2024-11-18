import 'package:flutter/material.dart';
import 'code_input_screen.dart';

class VerificationScreen extends StatelessWidget {
  final int points;
  final int level;
  final Function(int, int) onUpdate;
  final String requestDetail;

  const VerificationScreen({super.key,
    required this.points,
    required this.level,
    required this.onUpdate,
    required this.requestDetail
  });

  void _verifyRequest(BuildContext context) {
    // Simulate verification logic
    bool isValid = true; // In a real app, this would be dynamic

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CodeInputScreen(
          isValidRequest: isValid,
          points: points,
          level: level,
          onUpdate: onUpdate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simulated request details
    String requestDetail = 'Login attempt from New York, USA';

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Authentication Request Details:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              requestDetail,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyRequest(context),
              child: Text('Approve Request'),
            ),
          ],
        ),
      ),
    );
  }
}
