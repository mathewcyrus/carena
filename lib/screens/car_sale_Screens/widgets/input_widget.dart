import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class UserInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? replyto;
  final IconData? icon;
  final IconData? fileicon;
  final String? inputtype;
  final IconData? sendicon;
  final String? hintText;

  const UserInputField(
      {Key? key,
      required this.controller,
      this.replyto,
      this.hintText,
      this.fileicon,
      this.sendicon,
      this.inputtype,
      this.icon})
      : super(key: key);

  @override
  UserInputFieldState createState() => UserInputFieldState();
}

class UserInputFieldState extends State<UserInputField> {
  final int maxLines = 5;
  final lineHeight = 20.0; // Customize the line height as needed

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: widget.inputtype != "reviews"
            ? const Border(
                top: BorderSide(color: Colors.white10, width: 2.0),
              )
            : const Border(
                top: BorderSide.none,
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              maxLines: null,
              cursorColor: brandcolor,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        size: 35.0,
                        color: brandcolor,
                      )
                    : null,
                hintText: "reply to ${widget.replyto}",
                hintStyle: TextStyle(
                    fontSize: widget.inputtype == "reviews" ? 20.0 : 17.0),
                border: widget.inputtype == "reviews"
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      )
                    : InputBorder.none,
              ),
            ),
          ),
          (widget.fileicon != null || widget.sendicon != null)
              ? const SizedBox(width: 10.0)
              : const SizedBox.shrink(),
          widget.fileicon != null
              ? Icon(
                  widget.fileicon,
                  size: 35.0,
                )
              : const SizedBox.shrink(),
          (widget.fileicon != null || widget.sendicon != null)
              ? const SizedBox(width: 10.0)
              : const SizedBox.shrink(),
          widget.fileicon != null
              ? Icon(
                  widget.sendicon,
                  size: 35.0,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
