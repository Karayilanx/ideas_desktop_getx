import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';

import '../../../../model/check_model.dart';
import '../../../../model/printer_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/printer/printer_service.dart';
import '../../../order-detail/component/select_printer.dart';

class ClosedChecksController extends BaseController {
  CheckService checkService = Get.find();
  PrinterService printerService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxBool hideSearch = RxBool(true);
  RxList<ClosedCheckListItem> checks = RxList([]);
  Rx<ClosedCheckListItem?> selectedCheck = Rx<ClosedCheckListItem?>(null);
  Rx<CheckDetailsModel?> checkDetail = Rx<CheckDetailsModel?>(null);
  RxList<GroupedCheckItem> groupedCheckItems = RxList<GroupedCheckItem>([]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getClosedChecks();
    });
  }

  Future getClosedChecks() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checks(await checkService.getTodaysClosedChecks(authStore.user!.branchId!));
    EasyLoading.dismiss();
  }

  bool isAccountSelected(ClosedCheckListItem item) {
    if (selectedCheck.value != null &&
        selectedCheck.value!.checkId == item.checkId) {
      return true;
    }
    return false;
  }

  void selectCheckAccount(ClosedCheckListItem item) {
    selectedCheck(item);
    getClosedCheckDetails(item.checkId);
  }

  Future getClosedCheckDetails(int? checkId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkDetail(
        await checkService.getCheckDetails(checkId, authStore.user!.branchId!));

    EasyLoading.dismiss();
    groupedCheckItems(getGroupedMenuItems(checkDetail.value!.basketItems!));
  }

  Future restoreCheck() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await checkService.restoreCheck(
      selectedCheck.value!.checkId,
      authStore.user!.branchId!,
      authStore.user!.terminalUserId!,
    );
    EasyLoading.dismiss();
    selectedCheck(null);
    await getClosedChecks();
  }

  Future printSlip() async {
    var checkId = selectedCheck.value!.checkId;
    bool print = true;
    if (checkDetail.value!.spendingLimit != null &&
        checkDetail.value!.payments!.checkAmount! <
            checkDetail.value!.spendingLimit!) {
      print = await openYesNoDialog(
          "Hesap harcama limitine ulaşmamıştır. Yine de yazdırmak istiyor musunuz?");
    }

    if (print) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers =
          await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      printers = printers!.where((element) => element.isSlipPrinter!).toList();
      if (printers.length > 1) {
        PrinterOutput? printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await printerService.printSlipCheck(
            checkId,
            authStore.user!.terminalUserId,
            printer.printerName!,
            authStore.user!.branchId!,
            printer.isGeneric!,
          );
          EasyLoading.dismiss();
        }
      } else if (printers.length == 1) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printSlipCheck(
          checkId,
          authStore.user!.terminalUserId,
          printers
              .where((element) => element.isSlipPrinter!)
              .first
              .printerName!,
          authStore.user!.branchId!,
          printers.where((element) => element.isSlipPrinter!).first.isGeneric!,
        );
        EasyLoading.dismiss();
      } else {
        showSnackbarError('Yazıcı bulunamadı!');
      }
    }
  }

  Future printClosedCheck() async {
    if (checkDetail.value != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers =
          await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      printers = printers!.where((element) => element.isCashPrinter!).toList();
      if (printers.length > 1) {
        var printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await printerService.printClosedCheck(checkDetail.value!.checkId,
              printer.printerName!, authStore.user!.branchId!);
          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printClosedCheck(
            checkDetail.value!.checkId,
            printers
                .where((element) => element.isCashPrinter!)
                .first
                .printerName!,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
      }
    }
  }

  void closePage() {
    Get.back();
  }

  void filterTables() {
    checks.refresh();
  }
}
