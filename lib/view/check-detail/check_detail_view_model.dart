import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/view/check-detail/order_logs_table.dart';
import '../../locale_keys_enum.dart';
import '../../model/check_model.dart';
import '../../model/printer_model.dart';
import '../../service/check/check_service.dart';
import '../../service/printer/printer_service.dart';
import '../_utility/service_helper.dart';
import '../authentication/auth_store.dart';
import '../order-detail/component/select_printer.dart';

class CheckDetailController extends BaseController {
  final int checkId = Get.arguments[0];
  final int? endOfDayId = Get.arguments[1];
  CheckService checkService = Get.find();
  PrinterService printerService = Get.find();
  RxInt selectedTab = RxInt(0);
  Rx<CheckDetailsModel?> checkDetail = Rx<CheckDetailsModel?>(null);
  RxList<GroupedCheckItem> groupedItems = RxList<GroupedCheckItem>([]);
  RxList<CheckLogModel> checkLogs = <CheckLogModel>[].obs;
  RxList<OrderLogModel> orderLogs = <OrderLogModel>[].obs;
  Rx<OrderLogsDataSource?> orderLogsDataSource = Rx<OrderLogsDataSource?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckDetails();
    });
  }

  Future getCheckDetails() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    if (endOfDayId == null) {
      checkDetail(await checkService.getCheckDetails(
          checkId, authStore.user!.branchId!));
      var res = await checkService.getLocalCheckLogs(
          authStore.user!.branchId!, checkId);
      if (res != null) checkLogs(res);
      var orderLogRes = await checkService.getLocalOrderLogs(
          authStore.user!.branchId!, checkId);
      if (orderLogRes != null) {
        orderLogs(orderLogRes);
        orderLogsDataSource(OrderLogsDataSource(
          logs: orderLogs,
        ));
      }
    } else {
      checkDetail(await checkService.getPastCheckDetails(
          checkId, authStore.user!.branchId!, endOfDayId!));
      var res = await checkService.getLocalPastCheckLogs(
          authStore.user!.branchId!, checkId, endOfDayId!);
      if (res != null) checkLogs(res);
      var orderLogRes = await checkService.getLocalPastOrderLogs(
          authStore.user!.branchId!, checkId, endOfDayId!);
      if (orderLogRes != null) {
        orderLogs(orderLogRes);
        orderLogsDataSource(OrderLogsDataSource(
          logs: orderLogs,
        ));
      }
    }
    if (checkDetail.value != null) {
      groupedItems(getGroupedMenuItems(checkDetail.value!.basketItems!));
    }
    EasyLoading.dismiss();
  }

  Future printCheck(int? checkId, int? endOfDayId) async {
    if (checkId != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers =
          await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      printers = printers!.where((element) => element.isCashPrinter!).toList();
      var printerName =
          localeManager.getStringValue(PreferencesKeys.CASH_PRINTER_NAME);

      if (printerName.isNotEmpty) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printCheck(checkId, authStore.user!.terminalUserId,
            printerName, authStore.user!.branchId!);
        EasyLoading.dismiss();
      }
      if (printers.length > 1) {
        var printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          if (endOfDayId == null) {
            await printerService.printClosedCheck(
                checkId, printer.printerName!, authStore.user!.branchId!);
          } else {
            await printerService.printPastCheck(checkId, printer.printerName!,
                authStore.user!.branchId!, endOfDayId);
          }
          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        if (endOfDayId == null) {
          await printerService.printClosedCheck(
              checkId,
              printers
                  .where((element) => element.isCashPrinter!)
                  .first
                  .printerName!,
              authStore.user!.branchId!);
        } else {
          await printerService.printPastCheck(
              checkId,
              printers
                  .where((element) => element.isCashPrinter!)
                  .first
                  .printerName!,
              authStore.user!.branchId!,
              endOfDayId);
        }
        EasyLoading.dismiss();
      }
    }
  }

  Future printSlip(int checkId, int? endOfDayId) async {
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
        if (endOfDayId == null) {
          await printerService.printSlipCheck(
            checkId,
            authStore.user!.terminalUserId,
            printer.printerName!,
            authStore.user!.branchId!,
            printer.isGeneric!,
          );
        } else {
          await printerService.printPastSlipCheck(
            checkId,
            authStore.user!.terminalUserId,
            printer.printerName!,
            authStore.user!.branchId!,
            printer.isGeneric!,
            endOfDayId,
          );
        }
        EasyLoading.dismiss();
      }
    } else if (printers.length == 1) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      if (endOfDayId == null) {
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
      } else {
        await printerService.printPastSlipCheck(
          checkId,
          authStore.user!.terminalUserId,
          printers
              .where((element) => element.isSlipPrinter!)
              .first
              .printerName!,
          authStore.user!.branchId!,
          printers.where((element) => element.isSlipPrinter!).first.isGeneric!,
          endOfDayId,
        );
      }
      EasyLoading.dismiss();
      // closePage(checkId);
    } else {
      showSnackbarError('Yazıcı bulunamadı!');
    }
  }

  changeSelectedTab(int index) {
    selectedTab(index);
  }
}
