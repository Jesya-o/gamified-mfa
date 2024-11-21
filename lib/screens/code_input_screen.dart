import 'package:flutter/material.dart';
import 'home_screen.dart';

class CodeInputScreen extends StatefulWidget {
  final bool isValidRequest;
  final int points;
  final int level;
  final Function(int, int) onUpdate;

  const CodeInputScreen({
    super.key,
    required this.isValidRequest,
    required this.points,
    required this.level,
    required this.onUpdate,
  });

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _secretCode = '';

  void _submitCode() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool isCodeCorrect = _secretCode == '123456';

      int newPoints = widget.points;
      int newLevel = widget.level;

      if (isCodeCorrect && widget.isValidRequest) {
        newPoints += 5;
        newPoints += 10;
        if (newPoints >= 50) {
          newLevel += 1;
          newPoints = 0;
        }
      }

      widget.onUpdate(newPoints, newLevel);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            authMessage: isCodeCorrect
                ? 'Authentication Successful!'
                : 'Authentication Failed!',
            points: newPoints,
            level: newLevel,
          ),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Secret Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Please enter your secret code:'),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Secret Code',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the code';
                  }
                  return null;
                },
                onSaved: (value) {
                  _secretCode = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitCode,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
