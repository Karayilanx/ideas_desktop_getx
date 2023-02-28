import 'package:flutter/material.dart';

class FastSellInput extends StatelessWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final bool? enabled;
  final Color? fillColor;
  final Color? selectedColor;
  final TextInputType type;
  final bool isSelected;
  final VoidCallback callback;
  const FastSellInput({
    this.ctrl,
    this.hintText,
    this.enabled,
    this.type = TextInputType.text,
    this.fillColor,
    this.selectedColor,
    required this.isSelected,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      onTap: () => callback(),
      decoration: InputDecoration(
          fillColor: isSelected ? selectedColor : fillColor,
          focusColor: selectedColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          isDense: true,
          filled: true),
      enabled: enabled,
      showCursor: isSelected,
      readOnly: true,
      style: TextStyle(),
    );
  }
}
