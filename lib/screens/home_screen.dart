import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_service.dart';
import 'verification_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? authMessage;
  final int points;
  final int level;

  const HomeScreen({
    super.key,
    this.authMessage,
    this.points = 0,
    this.level = 1
  });

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
    _loadGamificationData();

    if (widget.authMessage != null) {
      setState(() {
        authMessage = widget.authMessage;
      });
    }

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

  Future<void> _loadGamificationData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points') ?? 0;
      level = prefs.getInt('level') ?? 1;
    });
  }

  Future<void> _saveGamificationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', points);
    await prefs.setInt('level', level);
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
    final verificationCode = message.data['verificationCode'] ?? '';
    final requestDetail = message.data['requestDetail'] ?? 'Unknown request';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          points: points,
          level: level,
          onUpdate: _updateGamification,
          requestDetail: requestDetail,
          verificationCode: verificationCode,
        ),
      ),
    );
  }

  void _receiveRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          points: points,
          level: level,
          onUpdate: _updateGamification,
          requestDetail: 'request detail',
          verificationCode: '1234',
        ),
      ),
    );
  }

  void _updateGamification(int newPoints, int newLevel) {
    setState(() {
      points = newPoints;
      level = newLevel;
    });
    _saveGamificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticator'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
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
            GestureDetector(
              onTap: _receiveRequest,
              child: Text(
                'Waiting for authentication requests...',
                style: TextStyle(fontSize: 16), // Ensure it looks like regular text
              ),
            ),
            SizedBox(height: 40),
            Text('Points: $points'),
            Text('Level: $level'),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: points / 50,
              minHeight: 10,
            ),
            Text('$points/50 points to next level'),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddService(),
            ),
          );
        },
        child: Icon(Icons.qr_code), // QR code icon
      ),
    );
  }
}
