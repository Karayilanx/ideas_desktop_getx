import 'package:flutter/material.dart';
import '../../../../_utility/service_helper.dart';
import 'status_base_button.dart';
import '../../integration_delivery_view_model.dart';

class WaitingForCourierButton extends StatelessWidget with ServiceHelper {
  final String? getirId;
  final String? yemeksepetiId;
  final int? checkId;
  WaitingForCourierButton({
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
