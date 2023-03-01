import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_utility/service_helper.dart';
import 'status_base_button.dart';
import '../../integration_delivery_view_model.dart';

class OrderMakePaymentButton extends StatelessWidget with ServiceHelper {
  final String? getirId;
  final String? yemeksepetiId;
  final int? checkId;

  OrderMakePaymentButton({super.key, 
    this.getirId,
    this.yemeksepetiId,
    required this.checkId,
  });

  @override
  Widget build(BuildContext context) {
    final IntegrationDeliveryController value = Get.find();

    return StatusButton(
      callback: () {
        if (getirId != null && getirId != '') {
          value.navigateToDeliveryOrder(checkId, true);
        } else if (yemeksepetiId != null && yemeksepetiId != '') {
          value.navigateToDeliveryOrder(checkId, true);
        }
      },
      color: Colors.green[700]!,
      text: 'Ödeme Al',
    );
  }
}
