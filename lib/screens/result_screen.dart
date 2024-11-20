import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool success;

  ResultScreen({required this.success});

  @override
  Widget build(BuildContext context) {
    String message = success ? 'Authentication Successful!' : 'Authentication Failed!';
    Color messageColor = success ? Colors.green : Colors.red;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(authMessage: message),
        ),
            (route) => false,
      );
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(authMessage: message),
          ),
              (route) => false,
        );
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 24, color: messageColor),
        ),
      ),
    );
  }
}
