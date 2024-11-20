import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'verification_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? authMessage;

  const HomeScreen({super.key, this.authMessage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 0;
  int level = 1;
  String? authMessage;

  @override
  void initState() {
    super.initState();
    _requestPermissions();

    setState(() {
      authMessage = widget.authMessage;
    });

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

  void _requestPermissions() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  void _navigateToVerificationScreen(RemoteMessage message) {
    final verificationCode = message.data['verificationCode'] ?? ''; // Extract the verification code
    final requestDetail = message.data['requestDetail'] ?? 'Unknown request'; // Extract request details

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          points: points,
          level: level,
          onUpdate: _updateGamification,
          requestDetail: requestDetail,
          verificationCode: verificationCode, // Pass verification code
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
            if (authMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  authMessage!,
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
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
