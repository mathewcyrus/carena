import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final bool ispass;
  final TextInputType textInputType;
  final String? hintText;
  final String? labeltext;
  final IconData icon;
  final TextEditingController textEditingController;
  const UserInputField(
      {Key? key,
      required this.textInputType,
      required this.textEditingController,
      this.hintText,
      this.labeltext,
      required this.icon,
      this.ispass = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: borderwidth,
          ),
        ),
      ),
      keyboardType: textInputType,
      obscureText: ispass,
    );
  }
}
