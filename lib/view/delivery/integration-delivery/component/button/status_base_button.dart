import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback callback;
  const StatusButton(
      {required this.callback, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 150),
      child: Container(
        margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
        child: ElevatedButton(
          onPressed: () => callback(),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
