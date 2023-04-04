import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/service/printer/printer_service.dart';

import '../../model/check_model.dart';
import '../../service/check/check_service.dart';
import 'requests_store.dart';
import 'table/cancel_requests_table.dart';

class RequestsController extends BaseController {
  CheckService checkService = Get.find();
  PrinterService printerService = Get.find();
  RequestsStore requestsStore = Get.find();
  Rx<RequestsModel?> requests = Rx<RequestsModel?>(null);
  Rx<CancelRequestsDataSource?> source = Rx<CancelRequestsDataSource?>(null);
  @override
  void onInit() {
    super.onInit();

    ever(requestsStore.requests, (callback) {
      source(
          CancelRequestsDataSource(cancelRequests: callback.cancelRequests!));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRequests();
    });
  }

  Future getRequests() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await checkService.getRequests(authStore.user!.branchId!);
    if (res != null) {
      requests(res);
      source(CancelRequestsDataSource(
          cancelRequests: requests.value!.cancelRequests!));
    }
    EasyLoading.dismiss();
  }

  Future rejectCancelRequest(int checkMenuItemCancelRequestId) async {
    var confirm = await openYesNoDialog(
        'İptal talebini reddetmek istediğinizden emin misiniz?');
    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.rejectCancelRequest(checkMenuItemCancelRequestId);
      EasyLoading.dismiss();
      getRequests();
    }
  }

  Future confirmCancelRequest(int checkMenuItemCancelRequestId) async {
    var confirm = await openYesNoDialog(
        'İptal talebini onaylamak istediğinizden emin misiniz?');
    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.confirmCancelRequest(
        checkMenuItemCancelRequestId,
        authStore.user!.terminalUserId!,
      );
      EasyLoading.dismiss();
      getRequests();
    }
  }
}
