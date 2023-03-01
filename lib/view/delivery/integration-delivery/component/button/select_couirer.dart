import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/delivery/couirer/couirer_page.dart';
import '../../../../../model/delivery_model.dart';
import 'status_base_button.dart';
import '../../integration_delivery_view_model.dart';

class SelectCouirerButton extends StatelessWidget {
  final int checkId;
  final CourierModel? courierModel;
  const SelectCouirerButton({
    super.key,
    required this.checkId,
    required this.courierModel,
  });

  @override
  Widget build(BuildContext context) {
    IntegrationDeliveryController controller = Get.find();
    return StatusButton(
      callback: () async {
        var res = await showDialog(
          context: context,
          builder: (context) => const CouirerPage(),
        );
        if (res != null) {
          controller.setCourier(checkId, res);
        }
      },
      color: Colors.red[700]!,
      text: courierModel == null ? 'Kurye Seç' : courierModel!.courierName!,
    );
  }
}
