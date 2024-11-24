import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/badge_animation.dart';
import '../elements/fade_badge.dart';
import '../elements/gamification_manager.dart';
import '../elements/points_display.dart';
import 'home_screen.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({super.key});

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _secretCode = '';
  bool _isGamificationEnabled = true;

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

  Future<void> _submitCode() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool isCodeCorrect = _secretCode == '123456';

      String message = isCodeCorrect
          ? "Authentication Successful!"
          : "Authentication Failed!";
      Color badgeColor = isCodeCorrect ? Colors.green : Colors.red;

      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => FadeBadge(message: message, color: badgeColor),
        ),
      );

      if (isCodeCorrect) {
        int currentPoints = await GamificationManager.getPoints();
        int currentLevel = await GamificationManager.getLevel();

        int newPoints = currentPoints + 5;
        if (newPoints >= 50) {
          currentLevel += 1;
          newPoints = 0;
        }

        await GamificationManager.updatePoints(newPoints);
        await GamificationManager.updateLevel(currentLevel);

        if (_isGamificationEnabled) {
          Overlay.of(context)?.insert(
            OverlayEntry(
              builder: (context) => BadgeAnimation(text: "+5"),
            ),
          );
        }
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Secret Code'),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Please enter your secret code:'),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Secret Code',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the code';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _secretCode = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitCode,
                      child: Text('Submit'),
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
