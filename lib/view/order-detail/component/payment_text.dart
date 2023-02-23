import 'package:flutter/material.dart';

class PaymentText extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final double fontSize;
  const PaymentText(
      {Key? key, this.firstText, this.secondText, this.fontSize = 22})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(
          flex: 3,
        ),
        Expanded(
          flex: 10,
          child: Text(firstText!,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
        ),
        Expanded(
          flex: 10,
          child: Text(secondText!,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF1A159),
                  fontSize: fontSize)),
        ),
        Spacer(
          flex: 3,
        )
      ],
    );
  }
}
