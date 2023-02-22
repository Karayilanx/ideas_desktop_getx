import 'package:flutter/material.dart';

class KeyboardNumericButton extends StatelessWidget {
  final int number;
  final TextEditingController? ctrl;
  final int? callBackLength;
  final VoidCallback? callback;
  final Color buttonColor;
  final OutlinedBorder shape;
  final TextStyle? style;
  const KeyboardNumericButton({
    super.key,
    required this.number,
    required this.ctrl,
    this.callBackLength,
    this.callback,
    required this.buttonColor,
    required this.shape,
    this.style = const TextStyle(fontSize: 22),
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, shape: shape),
          onPressed: () {
            if (callBackLength != null && ctrl!.text.length < callBackLength!) {
              ctrl!.text += number.toString();
            }
            if (callBackLength != null && ctrl!.text.length == callBackLength) {
              callback!();
            }
            if (callBackLength == null) ctrl!.text += number.toString();
          },
          child: Text(number.toString(), style: style),
        ),
      ),
    );
  }
}
