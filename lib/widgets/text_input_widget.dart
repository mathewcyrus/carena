import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final bool ispass;
  final TextInputType textInputType;
  final String hintText;
  final TextEditingController textEditingController;
  const UserInputField(
      {Key? key,
      required this.textInputType,
      required this.textEditingController,
      required this.hintText,
      this.ispass = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
            borderRadius: BorderRadius.circular(20.0)),
      ),
      keyboardType: textInputType,
      obscureText: ispass,
    );
  }
}