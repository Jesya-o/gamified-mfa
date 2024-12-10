import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:mfa_gamification/config/points.dart';
import 'package:mfa_gamification/screens/settings_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/fade_badge.dart';
import '../util/custom_colors.dart';
import 'home_screen.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  bool _isGamificationEnabled = false;
  int _numberOfServices = 1;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isGamificationEnabled = prefs.getBool(gamificationEnabledFlag) ?? false;
    });
  }

  Future<void> _addService() async {
    final prefs = await SharedPreferences.getInstance();
    _numberOfServices = prefs.getInt(numberOfConnectedServices) ?? 1;
    await prefs.setInt(numberOfConnectedServices, _numberOfServices + 1);
    _proceed();
  }

  Future<void> _proceed() async {
    if (_isGamificationEnabled) {
      String message = "Congrats! You protected one more service!";
      if (_numberOfServices  == colorfulInputAvailabilityServicesNumber) {
        message = "Yohhhoo! Colorful input is now unlocked!";
      } else if (_numberOfServices < colorfulInputAvailabilityServicesNumber) {
        message += "\nAdd ${colorfulInputAvailabilityServicesNumber - _numberOfServices} more services to unlock colorful input";
      }
      Overlay.of(context)?.insert(
        OverlayEntry(
          builder: (context) => FadeBadge(
              message: message,
              color: Theme.of(context).extension<CustomColors>()!.successColor),
        ),
      );
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: defaultSpaceBtwElements),
            Container(
              width: qrSize + 100,
              height: qrSize + 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).indicatorColor,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              ),
              child: Center(
                child: QrImageView(
                  data: 'Sample QR Code Data',
                  version: QrVersions.auto,
                  size: qrSize,
                ),
              ),
            ),
            SizedBox(height: defaultSpaceBtwElements * 3),
            ElevatedButton(onPressed: _addService, child: Text('Add Service'))
          ],
        ),
      ),
    );
  }
}
