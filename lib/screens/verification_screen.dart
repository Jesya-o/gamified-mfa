import 'package:flutter/material.dart';
import 'code_input_screen.dart';

class VerificationScreen extends StatefulWidget {
  final int points;
  final int level;
  final Function(int, int) onUpdate;
  final String requestDetail;
  final String verificationCode;

  const VerificationScreen({
    super.key,
    required this.points,
    required this.level,
    required this.onUpdate,
    required this.requestDetail,
    required this.verificationCode,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredCode = '';

  void _verifyRequest() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool isValid = _enteredCode == widget.verificationCode;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeInputScreen(
            isValidRequest: isValid,
            points: widget.points,
            level: widget.level,
            onUpdate: widget.onUpdate,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
    );
  }
}
