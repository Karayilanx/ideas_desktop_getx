import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../../../model/check_account_model.dart';
import '../../../../model/check_model.dart';
import '../../../../model/printer_model.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../../../../service/printer/printer_service.dart';
import '../table/check_account_transactions_table.dart';
import '../../check-accounts/component/select_check_account_view.dart';
import '../../../order-detail/component/select_printer.dart';
import '../../../order-detail/model/order_detail_model.dart';
import '../../../order-detail/navigation/table_detail_navigation_args.dart';

class CheckAccountTransactionsController extends BaseController {
  final int? checkAccountId = Get.arguments;
  PrinterService printerService = Get.find();
  CheckAccountService checkAccountService = Get.find();
  Rx<GetCheckAccountTransactionsOutput?> checkAccount =
      Rx<GetCheckAccountTransactionsOutput?>(null);
  Rx<CheckAccountTransactionsDataSource?> source =
      Rx<CheckAccountTransactionsDataSource?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckAccountTransactions();
    });
  }

  void navigateToCheckDetail(int checkId) {
    Get.toNamed('order-detail',
        arguments: TableDetailArguments(
            tableId: -1,
            checkId: checkId,
            type: OrderDetailPageType.TABLE,
            isIntegration: false));
  }

  expandPanel(bool expand, int index) {
    checkAccount.value!.checkAccountTransactions![index].expaned = !expand;
    checkAccount.refresh();
  }

  Future getCheckAccountTransactions() async {
    await checkAccountService.getCheckAccountSummary(checkAccountId);
    checkAccount(
        await checkAccountService.getCheckAccountTransactions(checkAccountId));

    if (checkAccount.value == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else {
      source(CheckAccountTransactionsDataSource(account: checkAccount.value!));
    }
  }

  String getCondimentText(CheckMenuItemModel item) {
    String ret = '';
    for (var menuItem in item.condiments!) {
      ret += menuItem.nameTr! + ',';
    }
    return ret;
  }

  Future transferCheckAccountTransaction(
      int checkAccountId, int? endOfDayId) async {
    var res = await Get.dialog(SelectCheckAccountPage(),
        arguments: [checkAccountId, false, endOfDayId]);
    if (res != null && res) {
      getCheckAccountTransactions();
    }
  }

  Future removeCheckAccountTransaction(int checkAccountTransactionId) async {
    var dialogResult = await openYesNoDialog(
        'İşlemi silmek istediğinizden emin misiniz? Bu işlemin geri dönüşü YOKTUR.');

    if (dialogResult) {
      EasyLoading.show(
        status: 'Lütfen bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );

      await checkAccountService
          .removeCheckAccountTransaction(checkAccountTransactionId);

      EasyLoading.dismiss();

      await getCheckAccountTransactions();
    }
  }

  Future printCheckAccountCheck(int? checkId, int? endOfDayId) async {
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
}
