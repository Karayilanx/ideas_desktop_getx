import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../model/check_model.dart';

class CondimentButton extends StatelessWidget {
  final CondimentModel condiment;
  final VoidCallback callback;
  final bool isSelected;
  const CondimentButton(
      {required this.condiment,
      required this.callback,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: isSelected && !condiment.isIngredient!
              ? Color(0xffF1A159)
              : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: AutoSizeText(
                  condiment.nameTr!,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                    decoration: isSelected && condiment.isIngredient!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Text(
                  condiment.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    decoration: isSelected && condiment.isIngredient!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: isSelected && !condiment.isIngredient!
                        ? Colors.white
                        : Color(0xffF1A159),
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
