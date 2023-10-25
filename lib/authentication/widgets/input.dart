import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final bool ispass;
  final IconData prefixicon;
  final TextInputType textInputType;
  final String? labeltext;
  final String? type;
  final String? hinttext;
  final TextEditingController? textEditingController;
  const UserInputField(
      {Key? key,
      required this.textInputType,
      this.textEditingController,
      this.labeltext,
      this.hinttext,
      this.type,
      required this.prefixicon,
      this.ispass = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      enabled: type == "readonly" ? false : true,
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefixicon,
            color: brandcolor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderwidth,
              color: type == "readonly" ? bordercolor : brandcolor,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: borderwidth, color: brandcolor),
          ),
          labelText: labeltext,
          hintText: hinttext),
      obscureText: ispass,
    );
  }
}
