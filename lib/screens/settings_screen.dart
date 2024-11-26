import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme_data.dart';
import '../util/gamification_manager.dart';
import '../main.dart';

const String gamificationEnabledFlag = 'isGamificationEnabled';
const String colorfulInputFlag = 'isColorfulInput';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isGamificationEnabled = true;
  bool _isColorfulInput = false;

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

  Future<void> _toggleGamification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(gamificationEnabledFlag, value);
    setState(() {
      _isGamificationEnabled = value;
    });
  }

  Future<void> _toggleInput(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(colorfulInputFlag, value);
    setState(() {
      _isColorfulInput = value;
    });
  }

  Future<bool> _isColorfulInputAvailable() async {
    int currentLevel = await GamificationManager.getLevel();
    return currentLevel > colorfulInputAvailabilityLevel;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                  'Enable gamification',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: _isGamificationEnabled,
                  onChanged: _toggleGamification,
                ),
              ],
            ),
            SizedBox(height: defaultSpaceBtwElements),
            FutureBuilder<bool>(
              future: _isColorfulInputAvailable(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final isAvailable = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Colorful secret code input',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isAvailable ? null : optionNotAvailableColor),
                    ),
                    Switch(
                      value: isAvailable ? _isColorfulInput : false,
                      onChanged: isAvailable ? _toggleInput : null,
                    ),
                  ],
                );
              },
            ),
            Text('Number of connected services: $numberOfConnectedServices',
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: defaultSpaceBtwElements * 2),
            Text('Change App Style',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: defaultSpaceBtwElements),
            ListTile(
              title: Text('Light Classics',
                  style: Theme.of(context).textTheme.bodyLarge),
              trailing: Radio<bool>(
                value: false,
                groupValue: themeProvider.currentTheme == darkTheme,
                onChanged: (value) {
                  themeProvider.toggleTheme(false);
                },
              ),
            ),
            ListTile(
              title: Text('Dark Sunset',
                  style: Theme.of(context).textTheme.bodyLarge),
              trailing: Radio<bool>(
                value: true,
                groupValue: themeProvider.currentTheme == darkTheme,
                onChanged: (value) {
                  themeProvider.toggleTheme(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
