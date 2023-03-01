import 'package:flutter/material.dart';

import '../../../../image/image_constatns.dart';

class DeliveryTableTextCell extends StatelessWidget {
  final String text;

  const DeliveryTableTextCell({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class DeliveryTableTextImageCell extends StatelessWidget {
  final String text;

  const DeliveryTableTextImageCell({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
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
