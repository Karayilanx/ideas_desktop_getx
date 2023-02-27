import 'package:flutter/material.dart';

import '../../../../image/image_constatns.dart';

class DeliveryTableTextCell extends StatelessWidget {
  final String text;

  const DeliveryTableTextCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class DeliveryTableTextImageCell extends StatelessWidget {
  final String text;

  const DeliveryTableTextImageCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.asset(
              ImageConstants.instance.getirLogo,
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
