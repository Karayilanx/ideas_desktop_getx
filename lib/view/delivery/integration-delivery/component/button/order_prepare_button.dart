import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'status_base_button.dart';
import '../update-status-dialog/update_status_dialog_view_model.dart';
import '../../integration_delivery_view_model.dart';

class OrderPrepareButton extends StatelessWidget {
  final String? getirId;
  final int? fuudyId;
  final int? getirStatus;
  final String? yemeksepetiId;
  final bool getirGetirsin;

  const OrderPrepareButton({
    super.key,
    this.getirId,
    this.yemeksepetiId,
    required this.getirStatus,
    required this.getirGetirsin,
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
            if (getirStatus == 500) {
              dialogValue.prepareGetirOrder(getirId!);
            } else if (getirStatus == 550) {
              dialogValue.handoverGetirOrder(getirId!);
            }
          } else if (yemeksepetiId != null && yemeksepetiId != '') {
            dialogValue.prepareYemeksepetiOrder(yemeksepetiId!);
          } else if (fuudyId != null) {
            // dialogValue!.fuudyCariyeAt(fuudyId!);
          }
        } else {
          value.openUpdateStatusDialog(getirId, yemeksepetiId, fuudyId);
        }
      },
      color: Colors.green[700]!,
      text: getButtonStatusText(),
    );
  }

  String getButtonStatusText() {
    if (getirId != null) {
      if (getirGetirsin) {
        if (getirStatus == 500) {
          return 'Hazırlandı';
        } else if (getirStatus == 550) {
          return 'Kuryeye Teslim Et';
        } else {
          return 'HATA';
        }
      } else {
        return 'Yola Çıkar';
      }
    } else if (fuudyId != null) {
      return 'Cariye At';
    } else {
      return 'Yola Çıkar';
    }
  }
}
