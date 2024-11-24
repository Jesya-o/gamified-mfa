import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/badge_animation.dart';
import '../elements/fade_badge.dart';
import '../elements/gamification_manager.dart';
import '../elements/numeric_keypad.dart';
import '../elements/points_display.dart';
import '../elements/shake_animation.dart';
import 'home_screen.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({super.key});

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _inputCode = '';
  bool _isGamificationEnabled = true;
  bool _shouldShake = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isGamificationEnabled = prefs.getBool('isGamificationEnabled') ?? true;
    });
  }

  Future<void> _proceed() async {
    if (_isGamificationEnabled) {
      String message = "Authentication Successful!";

      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => FadeBadge(message: message, color: Colors.lightGreen),
        ),
      );
      
      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => BadgeAnimation(text: "+5"),
        ),
      );
    }

    int currentPoints = await GamificationManager.getPoints();
    int currentLevel = await GamificationManager.getLevel();

    int newPoints = currentPoints + 5;
    if (newPoints >= 50) {
      currentLevel += 1;
      newPoints = 0;
    }

    await GamificationManager.updatePoints(newPoints);
    await GamificationManager.updateLevel(currentLevel);
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
    );
  }

  Future<void> _submitCode() async {
    bool isCodeCorrect = _inputCode == '123456';
    if (isCodeCorrect) {
      _proceed();
    } else {
      setState(() {
        _shouldShake = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _inputCode = '';
          _shouldShake = false;
        });
      });
    }
  }

  void _onNumberTap(String number) {
    setState(() {
      if (_inputCode.length < 6) {
        _inputCode += number;
      }
    });
  }

  void _onBackspaceTap() {
    setState(() {
      if (_inputCode.isNotEmpty) {
        _inputCode = _inputCode.substring(0, _inputCode.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter Secret Code',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ShakeAnimation(
                      shouldShake: _shouldShake,
                      child: Text(
                        _inputCode,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    NumericKeypad(
                      onNumberTap: _onNumberTap,
                      onBackspaceTap: _onBackspaceTap,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _inputCode.isNotEmpty ? _submitCode : null,
                      child: Text('Verify'),
                    ),
                  ],
                ),
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
        ));
  }
}
