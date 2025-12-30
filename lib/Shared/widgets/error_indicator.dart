import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  String message;
  ErrorIndicator([this.message = 'Something went wrong']);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
