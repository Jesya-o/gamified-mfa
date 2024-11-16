import 'package:flutter/material.dart';
import 'verification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 0;
  int level = 1;

  void _receiveRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          points: points,
          level: level,
          onUpdate: _updateGamification,
        ),
      ),
    );
  }

  void _updateGamification(int newPoints, int newLevel) {
    setState(() {
      points = newPoints;
      level = newLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MFA Gamification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _receiveRequest,
              child: Text('Receive Authentication Request'),
            ),
            SizedBox(height: 40),
            Text('Points: $points'),
            Text('Level: $level'),
          ],
        ),
      ),
    );
  }
}
