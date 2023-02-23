import 'package:flutter/material.dart';

class OrderQuantityButton extends StatelessWidget {
  final String text;
  final TextEditingController ctrl;
  const OrderQuantityButton(this.text, this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: ElevatedButton(
            onPressed: () {
              if (text == '0,5' || text == '1,5') {
                ctrl.text = text;
              } else if (text == 'C') {
                ctrl.clear();
              } else {
                ctrl.text += text;
              }
            },
            child: Text(text)),
      ),
    );
  }
}
