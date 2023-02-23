import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback callback;

  const PaymentButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 90, minWidth: 90),
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: color,
        ),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class PaymentButtonRow extends StatelessWidget {
  final PaymentButton buttonLeft;
  final PaymentButton buttonRight;
  final int flex;
  const PaymentButtonRow(
      {Key? key,
      required this.buttonLeft,
      required this.buttonRight,
      this.flex = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: buttonLeft,
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 5,
            child: buttonRight,
          ),
        ],
      ),
    );
  }
}
