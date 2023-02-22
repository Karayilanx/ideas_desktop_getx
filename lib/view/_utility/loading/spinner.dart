import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  final String text;
  final Color color;
  const Spinner(this.text, {super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SpinKitFadingCircle(
          color: color,
          size: 50.0,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }
}
