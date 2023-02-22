import 'package:flutter/material.dart';

class KeyboardCustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;
  final OutlinedBorder shape;
  const KeyboardCustomButton(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.buttonColor,
      required this.shape});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, shape: shape),
        onPressed: () {
          onPressed();
        },
        child: child,
      ),
    );
  }
}
