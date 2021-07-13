import 'package:flutter/material.dart';

class AlertSnack extends StatelessWidget {
  final message;

  AlertSnack({this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(message));
  }
}
