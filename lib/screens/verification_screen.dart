import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../elements/badge_animation.dart';
import '../elements/gamification_manager.dart';
import '../elements/points_display.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _enteredCode = '';
  String _errorMessage = '';
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

  Future<void> _verifyRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_enteredCode == widget.verificationCode) {
        if (_isGamificationEnabled) {
          Overlay.of(context)?.insert(
            OverlayEntry(
              builder: (context) => BadgeAnimation(text: "+10"),
            ),
          );
        }

        int currentPoints = await GamificationManager.getPoints();
        int currentLevel = await GamificationManager.getLevel();

        int newPoints = currentPoints + 10;
        if (newPoints >= 50) {
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
      } else {
        setState(() {
          _errorMessage = 'Incorrect verification code. Authentication aborted.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Request'),
      ),
      body:
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Authentication Request Details:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.requestDetail,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Verification Code',
                          errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the verification code';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredCode = value!;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _verifyRequest,
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
          )
    );
  }
}
