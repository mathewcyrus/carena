import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showNotificationBar(
  BuildContext context,
  String message,
  IconData icon,
  Color iconcolor,
) {
  Flushbar(
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
  ).show(context);
}
