import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../model/check_account_model.dart';
import '../../../../model/check_model.dart';
import '../../../../model/printer_model.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../../../../service/printer/printer_service.dart';
import '../../../_utility/service_helper.dart';
import '../../../authentication/auth_store.dart';
import '../table/check_account_transactions_table.dart';
import '../../check-accounts/component/select_check_account_view.dart';
import '../../../order-detail/component/select_printer.dart';
import '../../../order-detail/model/order_detail_model.dart';
import '../../../order-detail/navigation/table_detail_navigation_args.dart';
part 'check_account_transactions_view_model.g.dart';

class CheckAccountTransactionsViewModel = _CheckAccountViewModelBase
    with _$CheckAccountTransactionsViewModel;

abstract class _CheckAccountViewModelBase
    with Store, BaseViewModel, ServiceHelper {
  final int? checkAccountId;
  late CheckAccountTransactionsViewModel viewModel;
  late PrinterService printerService;
  late CheckAccountService checkAccountService;
  late AuthStore authStore;
  @observable
  GetCheckAccountTransactionsOutput? checkAccount;
  @observable
  CheckAccountTransactionsDataSource? source;

  _CheckAccountViewModelBase(this.checkAccountId);
  @override
  void setContext(BuildContext buildContext) =>
      this.buildContext = buildContext;
  void setModel(CheckAccountTransactionsViewModel value) => viewModel = value;
  @override
  void init() {
    authStore = buildContext!.read<AuthStore>();
    checkAccountService = CheckAccountService(networkManager!.networkManager);
    printerService = PrinterService(networkManager!.networkManager);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckAccountTransactions();
    });
  }

  void navigateToCheckDetail(int checkId) {
    navigation.navigateToPage(
        path: NavigationConstants.TABLE_DETAIL_VIEW,
        data: TableDetailArguments(
          type: OrderDetailPageType.TABLE,
          checkId: checkId,
          tableId: -1,
          isIntegration: false,
        ));
  }

  @action
  expandPanel(bool expand, int index) {
    checkAccount!.checkAccountTransactions![index].expaned = !expand;
    checkAccount = checkAccount;
  }

  @action
  Future getCheckAccountTransactions() async {
    await checkAccountService.getCheckAccountSummary(checkAccountId);
    checkAccount =
        await checkAccountService.getCheckAccountTransactions(checkAccountId);
    if (checkAccount == null) {
      navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else {
      source = CheckAccountTransactionsDataSource(
          account: checkAccount!, model: viewModel);
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
    var res = await showDialog(
      context: buildContext!,
      builder: (context) => SelectCheckAccountPage(
        checkAccountId: checkAccountId,
        transferAll: false,
        endOfDayId: endOfDayId,
      ),
    );
    if (res != null && res) {
      getCheckAccountTransactions();
    }
  }

  Future removeCheckAccountTransaction(int checkAccountTransactionId) async {
    var dialogResult = await openYesNoDialog(buildContext!,
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
        var printer = await showDialog(
          context: buildContext!,
          builder: (context) {
            return SelectPrinter(printers!);
          },
        );
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
