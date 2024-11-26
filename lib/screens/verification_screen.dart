import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfa_gamification/config/code.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../elements/badge_animation.dart';
import '../util/gamification_manager.dart';
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
  int _userLevel = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserLevel();
    _loadSettings();
  }

  Future<void> _fetchUserLevel() async {
    final level = await GamificationManager.getLevel();
    setState(() {
      _userLevel = level;
    });
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

  String generateRandomSixDigitCode() {
    final random = Random();
    final code = random.nextInt(900000) + 100000; // Ensures a 6-digit number
    return code.toString();
  }

  Widget _buildVerificationWidget() {
    if (_userLevel <= beginnerLevel) {
      return Column(
        children: [
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
      );
    } else if (_userLevel <= masterLevel) {
      final options = List<String>.from([
        widget.verificationCode,
        generateRandomSixDigitCode(),
        generateRandomSixDigitCode(),
        generateRandomSixDigitCode(),
      ]..shuffle());

      return Column(
        children: options
            .map((option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _inputCode = option;
                        });
                        _verifyCode();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.figtree().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                        foregroundColor: darkestBlue,
                        backgroundColor: snow,
                      ),
                      child: Text(option),
                    ),
                  ),
                ))
            .toList(),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _inputCode = verificationCodeInManualRequest;
          });
          _verifyCode();
        },
        child: Text('Verify'),
      );
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
                    if (_userLevel > masterLevel)
                      Text(
                        'Code: ${widget.verificationCode}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: defaultSpaceBtwElements),

                    SizedBox(height: inputScreenCodeMB),
                    _buildVerificationWidget(),
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
