import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../model/check_model.dart';
import '../../_utility/service_helper.dart';

class ClosedCheckListTile extends StatelessWidget with ServiceHelper {
  final ClosedCheckListItem check;
  final VoidCallback callback;
  final bool isSelected;
  ClosedCheckListTile({
    super.key,
    required this.check,
    required this.callback,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? const Color(0xffF1A159) : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: AutoSizeText(
                '${check.checkName!} Fiş No: ${check.checkId}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.black),
              ),
            ),
            Divider(color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: AutoSizeText(
                      "Açılış: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.blue[900]),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      getDateStringNumber(check.openDate!),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.blue[900]),
                    ),
                  )
                ],
              ),
            ),
            check.closeDate != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            "Kapanış: ",
                            style: TextStyle(
                                fontSize: 14,
                                color: isSelected ? Colors.white : Colors.red),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(
                            getDateStringNumber(check.closeDate!),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 14,
                                color: isSelected ? Colors.white : Colors.red),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 10, 10),
                  child: AutoSizeText(
                    'Bakiye: ${check.checkAmount!.toStringAsFixed(2)} TL',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black),
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
