import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/code.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/gamification_manager.dart';
import '../elements/points_display.dart';
import 'add_service.dart';
import 'verification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 0;
  int level = 1;
  String? authMessage;
  bool _isGamificationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _requestPermissions();
    _loadGamificationData();

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

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isGamificationEnabled = prefs.getBool(gamificationEnabledFlag) ?? true;
    });
  }

  Future<void> _loadGamificationData() async {
    points = await GamificationManager.getPoints();
    level = await GamificationManager.getLevel();
    setState(() {});
  }

  void _requestPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  void _navigateToVerificationScreen(RemoteMessage message) {
    final verificationCode = message.data[verificationCodeRequestParam] ?? '';
    final requestDetail = message.data[requestDetailRequestParam] ?? 'Unknown request';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
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
          requestDetail: 'request detail',
          verificationCode: verificationCodeInManualRequest,
        ),
      ),
    );
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
              ).then((_) => _loadSettings());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _receiveRequest,
                  child: Text(
                    'Waiting for authentication requests...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          if (_isGamificationEnabled)
            FutureBuilder(
              future: Future.wait([
                GamificationManager.getPoints(),
                GamificationManager.getLevel()
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final data = snapshot.data as List<int>;
                  return PointsDisplay(points: data[0], level: data[1]);
                }
                return SizedBox.shrink(); // Placeholder for loading
              },
            ),
        ],
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
