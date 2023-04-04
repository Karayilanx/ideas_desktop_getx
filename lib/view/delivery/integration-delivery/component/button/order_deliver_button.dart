import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../integration_delivery_view_model.dart';
import '../update-status-dialog/update_status_dialog_view_model.dart';
import 'status_base_button.dart';

class OrderDeliverButton extends StatelessWidget {
  final String? getirId;
  final int? checkId;
  final int? fuudyId;
  final String? yemeksepetiId;

  final bool isVale;
  const OrderDeliverButton({
    super.key,
    this.getirId,
    this.yemeksepetiId,
    this.checkId,
    required this.isVale,
    required this.fuudyId,
  });

  @override
  Widget build(BuildContext context) {
    final IntegrationDeliveryController value = Get.find();
    // final UpdateStatusDialogController dialogValue = Get.find();
    return StatusButton(
      callback: () {
        bool test = Get.isRegistered<UpdateStatusDialogController>();
        if (test) {
          UpdateStatusDialogController dialogValue = Get.find();
          if (getirId != null && getirId != '') {
            dialogValue.deliverGetirOrder(getirId!);
          } else if (yemeksepetiId != null && yemeksepetiId != '') {
            if (isVale) {
              dialogValue.deliverYemeksepetiValeOrder(yemeksepetiId!);
            } else {
              dialogValue.deliverYemeksepetiOrder(yemeksepetiId!);
            }
          } else if (fuudyId != null) {
            // dialogValue!.fuudyCariyeAt(fuudyId!);
          }
        } else {
          if (getirId == null &&
              yemeksepetiId == null &&
              fuudyId == null &&
              checkId != null) {
            value.navigateToDeliveryOrderDetail(checkId!);
          } else {
            value.openUpdateStatusDialog(getirId, yemeksepetiId, fuudyId);
          }
        }
      },
      color: Colors.green[700]!,
      text: 'Tamamla',
    );
  }
}
