import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class FlushBar extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconcolor;
  const FlushBar(
      {super.key,
      required this.message,
      required this.icon,
      required this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      message: message,
      messageSize: 17.0,
      padding: const EdgeInsets.all(16.0),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 5),
      isDismissible: false,
      icon: Icon(
        icon,
        color: iconcolor,
      ),
    );
  }
}
