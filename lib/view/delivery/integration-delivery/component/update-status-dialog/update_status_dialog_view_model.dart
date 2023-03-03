import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/service/getir_service.dart';
import 'package:ideas_desktop_getx/view/select-multi-printer/select_multi_printer_view.dart';
import '../../../../../model/getir_model.dart';
import '../../../../../model/printer_model.dart';
import '../../../../../model/yemeksepeti_model.dart';
import '../../../../../service/check/check_service.dart';
import '../../../../../service/printer/printer_service.dart';
import '../../../../../service/yemeksepeti/yemeksepeti_service.dart';
import '../button/status_helper.dart';

class UpdateStatusDialogController extends BaseController with StatusHelper {
  final String? getirId = Get.arguments != null ? Get.arguments[0] : null;
  final String? yemeksepetiId = Get.arguments != null ? Get.arguments[1] : null;
  final int? fuudyId = Get.arguments != null ? Get.arguments[2] : null;
  final bool isVale = Get.arguments != null ? Get.arguments[3] : false;
  GetirService getirService = Get.find();
  PrinterService printerService = Get.find();
  YemeksepetiService yemeksepetiService = Get.find();
  CheckService checkService = Get.find();

  Rx<YemeksepetiCheckDetailsModel?> yemeksepetiCheck =
      Rx<YemeksepetiCheckDetailsModel?>(null);
  Rx<GetirCheckDetailsModel?> getirCheck = Rx<GetirCheckDetailsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getirId != null && getirId != '') {
        getGetirOrderDetails();
      } else if (yemeksepetiId != null && yemeksepetiId != '') {
        getYemeksepetiOrderDetails();
      }
      // else if (fuudyId != null) {
      //   getFuudyOrderDetails();
      // }
    });
  }

  Future getGetirOrderDetails() async {
    if (getirId != null) {
      getirCheck(await getirService.getGetirOrderDetails(
          authStore.user!.branchId!, getirId!));
      if (getirCheck.value == null) {
        // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
      }
    }
  }

  Future getYemeksepetiOrderDetails() async {
    if (yemeksepetiId != null) {
      yemeksepetiCheck(await yemeksepetiService.getYemeksepetiOrderDetails(
          authStore.user!.branchId!, yemeksepetiId!));
      if (yemeksepetiCheck.value == null) {
        // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
      }
    }
  }

  Future verifyScheduledGetirOrder(String getirId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await getirService.verifyScheduledGetirOrder(
        authStore.user!.branchId!, getirId);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future verifyGetirOrder(String getirId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res =
        await getirService.verifyGetirOrder(authStore.user!.branchId!, getirId);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future verifyYemeksepetiOrder(String yemeksepetiId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId, 1, authStore.user!.terminalUserId!);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future verifyYemeksepetiValeOrder(String yemeksepetiId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await yemeksepetiService.updateValeOrder(
        authStore.user!.branchId!,
        yemeksepetiId,
        1,
        authStore.user!.terminalUserId!);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future prepareGetirOrder(String getirId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await getirService.prepareGetirOrder(
        authStore.user!.branchId!, getirId);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future handoverGetirOrder(String getirId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await getirService.handoverGetirOrder(
        authStore.user!.branchId!, getirId);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future prepareYemeksepetiOrder(String yemeksepetiId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId, 4, authStore.user!.terminalUserId!);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future deliverGetirOrder(String getirId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await getirService.deliverGetirOrder(
        authStore.user!.branchId!, getirId);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future deliverYemeksepetiOrder(String yemeksepetiId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId, 5, authStore.user!.terminalUserId!);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  // Future fuudyCariyeAt(int fuudyId) async {
  //   EasyLoading.show(
  //     status: 'Lütfen Bekleyiniz...',
  //     dismissOnTap: false,
  //     maskType: EasyLoadingMaskType.black,
  //   );
  //   var res =
  //       await fuudyService.fuudyCariyeAt(authStore.user!.branchId!, fuudyId);
  //   EasyLoading.dismiss();
  //   if (res != null) Get.back();
  // }

  Future deliverYemeksepetiValeOrder(String yemeksepetiId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await yemeksepetiService.updateValeOrder(
        authStore.user!.branchId!,
        yemeksepetiId,
        5,
        authStore.user!.terminalUserId!);
    EasyLoading.dismiss();
    if (res != null) Get.back();
  }

  Future openPrinterDialog(String? getirId, String? yemeksepetiId) async {
    var res = await Get.dialog(const SelectMultiPrinter());
    if (res != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      for (PrinterOutput printer in res) {
        if (getirId != null) {
          await printerService.printGetir(
              getirId, printer.printerName!, authStore.user!.branchId!);
        } else if (yemeksepetiId != null) {
          await printerService.printYemeksepeti(
              yemeksepetiId, printer.printerName!, authStore.user!.branchId!);
        }
      }
      EasyLoading.dismiss();
    }
  }
}
