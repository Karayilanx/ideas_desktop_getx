import 'package:flutter/material.dart';

class KeyboardTextButton extends StatelessWidget {
  final String text;
  final TextEditingController ctrl;
  final Color buttonColor;
  final OutlinedBorder shape;
  const KeyboardTextButton(
      {super.key,
      required this.text,
      required this.ctrl,
      required this.buttonColor,
      required this.shape});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(backgroundColor: buttonColor, shape: shape),
      onPressed: () {
        ctrl.text += text;
      },
      child: Text(
        text,
      ),
    );
  }
}
