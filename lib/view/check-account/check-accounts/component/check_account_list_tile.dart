import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../model/check_account_model.dart';

class CheckAccountListTile extends StatelessWidget {
  final CheckAccountListItem checkAcc;
  final VoidCallback callback;
  final bool isSelected;
  const CheckAccountListTile({super.key, required this.checkAcc, required this.callback, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: isSelected ? const Color(0xffF1A159) : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
              child: AutoSizeText(
                checkAcc.name!,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 20, color: isSelected ? Colors.white : Colors.black),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 16, 16),
                  child: AutoSizeText(
                    'Bakiye: ${checkAcc.balance!.toStringAsFixed(2)} TL',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20, color: isSelected ? Colors.white : Colors.black),
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
