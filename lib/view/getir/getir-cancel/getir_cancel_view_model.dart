import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/service/getir_service.dart';
import '../../../model/getir_model.dart';

class GetirCancelController extends BaseController {
  final String? getirId = Get.arguments;
  final TextEditingController ctrl = TextEditingController(text: '');
  Rx<String?> selectedReasonId = Rx<String?>(null);
  RxList<GetirCancelOption> cancelOptions = RxList([]);
  GetirService getirService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGetirCancelOptions();
    });
  }

  Future getGetirCancelOptions() async {
    cancelOptions(await getirService.getGetirCancelOptions(
        authStore.user!.branchId!, getirId!));
    selectedReasonId(cancelOptions[0].id!);
  }

  void changeSelectedReason(String id) {
    selectedReasonId(id);
  }

  void save() {
    if (ctrl.text.isNotEmpty) {
      Get.back(result: [ctrl.text, selectedReasonId.toString()]);
    }
  }
}
