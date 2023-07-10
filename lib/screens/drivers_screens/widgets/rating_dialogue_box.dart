import 'package:flutter/material.dart';

class RatingDialogueBox extends StatefulWidget {
  const RatingDialogueBox({super.key});

  @override
  State<RatingDialogueBox> createState() => _RatingDialogueBoxState();
}

class _RatingDialogueBoxState extends State<RatingDialogueBox> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.amber),
          height: 300.0,
          child: Text("Dialoue"),
        ),
      ),
    );
  }
}
