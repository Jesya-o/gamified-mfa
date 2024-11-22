import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add a Service',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            QrImageView(
              data: 'Sample QR Code Data',
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              'Scan this QR code to add a service',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
