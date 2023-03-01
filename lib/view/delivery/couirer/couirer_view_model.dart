import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/delivery_model.dart';
import 'package:ideas_desktop_getx/service/delivery/delivery_service.dart';

class CouirerController extends BaseController {
  DeliveryService deliveryService = Get.find();
  TextEditingController nameCtrl = TextEditingController();
  RxList<CourierModel> couriers = RxList([]);
  Rx<int?> selectedCourierId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCouriers();
    });
  }

  getCouriers() async {
    var res = await deliveryService.getCouriers(authStore.user!.branchId!);
    if (res != null) {
      couriers(res);
    }
  }

  selectCourier(int id) {
    selectedCourierId(id);
  }

  addCourier() async {
    if (nameCtrl.text != '') {
      var res = await deliveryService.createCourier(CourierModel(
        branchId: authStore.user!.branchId!,
        courierName: nameCtrl.text,
        courierId: -1,
      ));

      if (res != null) {
        await getCouriers();
        selectCourier(res.value!);
        Get.back(result: selectedCourierId);
      }
    } else if (selectedCourierId.value != null) {
      Get.back(result: selectedCourierId);
    }
  }

  deleteCourier() async {
    if (selectedCourierId.value != null) {
      var res = await deliveryService.deleteCourier(selectedCourierId.value!);
      if (res != null) {
        await getCouriers();
      }
    }
  }
}
