import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool success;

  ResultScreen({required this.success});

  @override
  Widget build(BuildContext context) {
    String message = success ? 'Authentication Successful!' : 'Authentication Failed!';
    Color messageColor = success ? Colors.green : Colors.red;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Return to HomeScreen
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Icon(Icons.home),
      ),
    );
  }
}
