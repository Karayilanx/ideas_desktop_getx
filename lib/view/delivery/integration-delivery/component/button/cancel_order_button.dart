import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'status_base_button.dart';
import '../../integration_delivery_view_model.dart';

class OrderCancelButton extends StatelessWidget {
  final String? getirId;
  final String? yemeksepetiId;
  final int? fuudyId;

  const OrderCancelButton({
    this.getirId,
    this.yemeksepetiId,
    this.fuudyId,
  });

  @override
  Widget build(BuildContext context) {
    final IntegrationDeliveryController value = Get.find();
    if (yemeksepetiId == null && fuudyId == null && getirId == null) {
      return Container();
    } else {
      return StatusButton(
        callback: () {
          if (getirId != null && getirId != '') {
            value.openGetirCancelDialog(getirId!);
          } else if (yemeksepetiId != null && yemeksepetiId != '') {
            value.openYemeksepetiCancelDialog(yemeksepetiId!);
          }
        },
        color: Colors.red[700]!,
        text: 'İptal',
      );
    }
  }
}
