import 'package:flutter/material.dart';
import 'package:mfa_gamification/config/config.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add a Service',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: defaultSpaceBtwElements),
            QrImageView(
              data: 'Sample QR Code Data',
              version: QrVersions.auto,
              size: qrSize,
            ),
            SizedBox(height: defaultSpaceBtwElements),
            Text(
              'Scan this QR code to add a service',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
