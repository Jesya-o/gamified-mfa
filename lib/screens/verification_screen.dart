import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/code.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/theme.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../elements/badge_animation.dart';
import '../elements/gamification_manager.dart';
import '../elements/numeric_keypad.dart';
import '../elements/points_display.dart';
import '../elements/shake_animation.dart';
import 'code_input_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String requestDetail;
  final String verificationCode;

  const VerificationScreen({
    super.key,
    required this.requestDetail,
    required this.verificationCode,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
      _isGamificationEnabled = prefs.getBool(gamificationEnabledFlag) ?? true;
    });
  }

  Future<void> _proceed() async {
    if (_isGamificationEnabled) {
      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => BadgeAnimation(text: "+$verificationPoints"),
        ),
      );
    }

    int currentPoints = await GamificationManager.getPoints();
    int currentLevel = await GamificationManager.getLevel();

    int newPoints = currentPoints + verificationPoints;
    if (newPoints >= levelUpPoints) {
      currentLevel += 1;
      newPoints = 0;
    }

    await GamificationManager.updatePoints(newPoints);
    await GamificationManager.updateLevel(currentLevel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CodeInputScreen(),
      ),
    );
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

  void _verifyCode() {
    if (_inputCode == widget.verificationCode) {
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
                      'Confirm the Request',
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
                    SizedBox(
                      width: keypadWidth,
                      height: keypadHeight,
                      child: NumericKeypad(
                        onNumberTap: _onNumberTap,
                        onBackspaceTap: _onBackspaceTap,
                      ),
                    ),
                    SizedBox(height: defaultSpaceBtwElements),
                    ElevatedButton(
                      onPressed: _inputCode.isNotEmpty ? _verifyCode : null,
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
                  return SizedBox.shrink();
                },
              ),
          ],
        ));
  }
}
