import 'package:flutter/material.dart';
import '../../../../_utility/service_helper.dart';
import 'status_base_button.dart';

class WaitingForCourierButton extends StatelessWidget with ServiceHelper {
  final String? getirId;
  final String? yemeksepetiId;
  final int? checkId;
  WaitingForCourierButton({
    super.key,
    this.getirId,
    this.yemeksepetiId,
    required this.checkId,
  });

  @override
  Widget build(BuildContext context) {
    return StatusButton(
      callback: () {
        showSnackbarError(
            'Getir kuryesinin siparişi teslim etmesi bekleniyor.');
      },
      color: Colors.green[700]!,
      text: 'Kuryenin Teslim Etmesi Bekleniyor',
    );
  }
}
