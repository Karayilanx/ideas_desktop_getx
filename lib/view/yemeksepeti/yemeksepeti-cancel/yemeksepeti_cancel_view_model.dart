import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../../model/yemeksepeti_model.dart';
import '../../../service/yemeksepeti/yemeksepeti_service.dart';

class YemeksepetiCancelController extends BaseController {
  final String? yemeksepetiId = Get.arguments;
  final TextEditingController ctrl = TextEditingController(text: '');
  Rx<int?> selectedReasonId = Rx<int?>(null);
  RxBool isLoading = RxBool(true);
  RxList<YemeksepetiRejectReason> cancelOptions = RxList([]);

  YemeksepetiService yemeksepetiService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getYemeksepetiRejectReasons();
    });
  }

  Future getYemeksepetiRejectReasons() async {
    cancelOptions(await yemeksepetiService
        .getYemeksepetiRejectReasons(authStore.user!.branchId!));
    selectedReasonId(cancelOptions[0].reasonId!);
    isLoading(false);
  }

  void changeSelectedReason(int id) {
    selectedReasonId(id);
  }

  void save() {
    Get.back(result: [ctrl.text, selectedReasonId.toString()]);
  }
}
