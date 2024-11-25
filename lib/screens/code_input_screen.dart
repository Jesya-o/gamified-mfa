import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/code.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/badge_animation.dart';
import '../elements/color_keypad.dart';
import '../elements/fade_badge.dart';
import '../elements/gamification_manager.dart';
import '../elements/numeric_keypad.dart';
import '../elements/points_display.dart';
import '../elements/shake_animation.dart';
import '../util/custom_colors.dart';
import 'home_screen.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({super.key});

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  String _inputCode = '';
  bool _isGamificationEnabled = true;
  bool _isColorfulInput = false;
  bool _shouldShake = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isGamificationEnabled = prefs.getBool(gamificationEnabledFlag) ?? true;
      _isColorfulInput = prefs.getBool(colorfulInputFlag) ?? true;
    });
  }

  Future<void> _proceed() async {
    if (_isGamificationEnabled) {
      String message = "Authentication Successful!";

      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => FadeBadge(
              message: message,
              color: Theme.of(context).extension<CustomColors>()!.successColor),
        ),
      );

      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => BadgeAnimation(text: "+$codePoints"),
        ),
      );
    }

    int currentPoints = await GamificationManager.getPoints();
    int currentLevel = await GamificationManager.getLevel();

    int newPoints = currentPoints + codePoints;
    if (newPoints >= levelUpPoints) {
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
    bool isCodeCorrect = _inputCode == secretCode;
    if (isCodeCorrect) {
      _proceed();
    } else {
      setState(() {
        _shouldShake = true;
      });

      Future.delayed(const Duration(milliseconds: shakeDelay), () {
        setState(() {
          _inputCode = '';
          _shouldShake = false;
        });
      });
    }
  }

  void _onNumberTap(String number) {
    setState(() {
      if (_inputCode.length < codeMaxLength) {
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(edgeInsets),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: inputScreenTitleMT),
                    Text(
                      'Enter Secret Code',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: inputScreenTitleMB),
                    ShakeAnimation(
                      shouldShake: _shouldShake,
                      child: Text(
                        _inputCode,
                        style: TextStyle(
                          fontSize: inputScreenCodeTextSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: inputScreenCodeLetterSpacing,
                        ),
                      ),
                    ),
                    SizedBox(height: inputScreenCodeMB),
                    if (!_isColorfulInput)
                      SizedBox(
                        width: keypadWidth,
                        height: keypadHeight,
                        child: NumericKeypad(
                          onNumberTap: _onNumberTap,
                          onBackspaceTap: _onBackspaceTap,
                        ),
                      ),
                    if (_isColorfulInput)
                      SizedBox(
                        width: colorKeypadWidth,
                        height: keypadHeight,
                        child: ColorKeypad(
                          onColorTap: _onNumberTap,
                        ),
                      ),
                    SizedBox(height: defaultSpaceBtwElements),
                    if (_isColorfulInput)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed:
                                _inputCode.isNotEmpty ? _submitCode : null,
                            child: Text('Submit'),
                          ),
                          SizedBox(width: submitAndBackSpace),
                          IconButton(
                            icon: Icon(Icons.backspace),
                            onPressed: () {
                              setState(() {
                                if (_inputCode.isNotEmpty) {
                                  _inputCode = _inputCode.substring(
                                      0, _inputCode.length - 1);
                                }
                              });
                            },
                          ),
                          SizedBox(width: backspaceMR),
                        ],
                      ),
                    if (!_isColorfulInput)
                      ElevatedButton(
                        onPressed: _inputCode.isNotEmpty ? _submitCode : null,
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
                  return SizedBox.shrink();
                },
              ),
          ],
        ));
  }
}
