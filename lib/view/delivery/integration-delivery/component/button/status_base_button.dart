import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback callback;
  const StatusButton(
      {super.key,
      required this.callback,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: Container(
        margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
        child: ElevatedButton(
          onPressed: () => callback(),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
