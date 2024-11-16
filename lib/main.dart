import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MfaGamificationApp());
}

class MfaGamificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MFA Gamification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
