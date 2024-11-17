import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'verification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 0;
  int level = 1;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _navigateToVerificationScreen(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _navigateToVerificationScreen(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigateToVerificationScreen(message);
    });
  }

  void _navigateToVerificationScreen(RemoteMessage message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          points: points,
          level: level,
          onUpdate: _updateGamification,
          requestDetail: message.data['requestDetail'] ?? 'Unknown request',
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
            Text('Waiting for authentication requests...'),
            SizedBox(height: 40),
            Text('Points: $points'),
            Text('Level: $level'),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: points / 50,
              minHeight: 10,
            ),
            Text('$points/50 points to next level'),
          ],
        ),
      ),
    );
  }
}
