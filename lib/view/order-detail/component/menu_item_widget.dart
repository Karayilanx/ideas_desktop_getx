import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../model/menu_model.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback callback;
  const MenuItemWidget(
      {super.key, required this.menuItem, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: AutoSizeText(
                  menuItem.nameTr!,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 2),
                child: AutoSizeText(
                  menuItem.priceToShow.toStringAsFixed(2),
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xffF1A159),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
