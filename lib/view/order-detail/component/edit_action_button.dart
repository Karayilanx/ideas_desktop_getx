import 'package:flutter/material.dart';

const defaultColor = Color(0xffF1A159);

class EditActionButton extends StatelessWidget {
  final String? text;
  final VoidCallback? callback;
  final Color color;
  const EditActionButton(
      {Key? key, this.text, this.callback, this.color = defaultColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          callback!();
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
        child: Text(
          text!,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
