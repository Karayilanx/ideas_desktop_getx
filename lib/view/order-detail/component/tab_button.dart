import 'package:flutter/material.dart';
import 'tab_button_position_enum.dart';

class TabButton extends StatelessWidget {
  final bool selected;
  final VoidCallback callback;
  final String text;
  final TabButtonPosition position;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double fontSize;
  final double minWidht;
  final double radius;
  const TabButton(
      {super.key,
      required this.selected,
      required this.callback,
      required this.text,
      required this.position,
      required this.selectedColor,
      required this.unselectedColor,
      required this.fontSize,
      required this.minWidht,
      required this.radius,
      required this.selectedTextColor,
      required this.unselectedTextColor});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidht),
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? selectedColor : unselectedColor,
          shape: createShape(),
          padding: const EdgeInsets.all(8),
        ),
        child: Text(
          text,
          style: selected
              ? TextStyle(fontSize: fontSize, color: selectedTextColor)
              : TextStyle(fontSize: fontSize, color: unselectedTextColor),
        ),
      ),
    );
  }

  createShape() {
    if (position == TabButtonPosition.LEFT) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)));
    } else if (position == TabButtonPosition.MIDDLE) {
      return const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(0)));
    } else if (position == TabButtonPosition.RIGHT) {
      return RoundedRectangleBorder(
          borderRadius:
              BorderRadius.horizontal(right: Radius.circular(radius)));
    }
  }
}
