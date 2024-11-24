import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String gamificationEnabledFlag = 'isGamificationEnabled';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isGamificationEnabled = true;

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

  Future<void> _toggleGamification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(gamificationEnabledFlag, value);
    setState(() {
      _isGamificationEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(edgeInsets),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enable Gamification',
                  style: TextStyle(fontSize: titleTextSize),
                ),
                Switch(
                  value: _isGamificationEnabled,
                  onChanged: _toggleGamification,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
