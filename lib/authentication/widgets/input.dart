import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final bool ispass;
  final IconData prefixicon;
  final TextInputType textInputType;
  final String labeltext;
  final TextEditingController textEditingController;
  const UserInputField(
      {Key? key,
      required this.textInputType,
      required this.textEditingController,
      required this.labeltext,
      required this.prefixicon,
      this.ispass = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixicon,
          color: brandcolor,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: borderwidth, color: brandcolor),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: borderwidth, color: brandcolor),
        ),
        labelText: labeltext,
      ),
      obscureText: ispass,
    );
  }
}
