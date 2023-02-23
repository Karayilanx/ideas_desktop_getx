import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuItemCategoryButton extends StatelessWidget {
  final String? text;
  final bool? selected;
  final VoidCallback? callback;
  final EdgeInsets? margin;
  const MenuItemCategoryButton({
    super.key,
    this.text,
    this.selected,
    this.callback,
    this.margin = const EdgeInsets.only(right: 4),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 120,
      margin: margin,
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
          backgroundColor: selected! ? const Color(0xffF1A159) : Colors.white,
        ),
        child: AutoSizeText(
          text!,
          maxLines: 2,
          wrapWords: false,
          style: TextStyle(
            fontSize: 16,
            color: !selected! ? const Color(0xffF1A159) : Colors.white,
          ),
        ),
      ),
    );
  }
}
