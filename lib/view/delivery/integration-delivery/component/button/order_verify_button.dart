import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'status_base_button.dart';
import '../update-status-dialog/update_status_dialog_view_model.dart';
import '../../integration_delivery_view_model.dart';

class OrderVerifyButton extends StatelessWidget {
  final String? getirId;
  final int? getirStatus;
  final int? fuudyId;
  final String? yemeksepetiId;

  final bool isVale;
  const OrderVerifyButton({
    super.key,
    this.getirId,
    this.yemeksepetiId,
    this.getirStatus,
    required this.isVale,
    required this.fuudyId,
  });

  @override
  Widget build(BuildContext context) {
    final IntegrationDeliveryController value = Get.find();

    return StatusButton(
      callback: () {
        bool test = Get.isRegistered<UpdateStatusDialogController>();
        if (test) {
          final UpdateStatusDialogController dialogValue = Get.find();
          if (getirId != null && getirId != '') {
            if (getirStatus == 325) {
              dialogValue.verifyScheduledGetirOrder(getirId!);
            } else if (getirStatus == 400) {
              dialogValue.verifyGetirOrder(getirId!);
            }
          } else if (yemeksepetiId != null && yemeksepetiId != '') {
            if (isVale) {
              dialogValue.verifyYemeksepetiValeOrder(yemeksepetiId!);
            } else {
              dialogValue.verifyYemeksepetiOrder(yemeksepetiId!);
            }
          } else if (fuudyId != null) {
            // dialogValue!.fuudyCariyeAt(fuudyId!);
          }
        } else {
          value.openUpdateStatusDialog(getirId, yemeksepetiId, fuudyId);
        }
      },
      color: Colors.green[700]!,
      text: getirStatus != null && getirStatus == 325 ? 'Ön Onayla' : 'Onayla',
    );
  }
}
