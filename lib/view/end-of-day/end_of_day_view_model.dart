// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/extension/string_extension.dart';
import 'package:ideas_desktop/model/eft_pos_model.dart';
import 'package:ideas_desktop/service/branch/branch_service.dart';
import 'package:ideas_desktop/service/eft_pos/eft_pos_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/service/stock/stock_service.dart';
import 'package:ideas_desktop/view/end-of-day/select-report/select_report_view.dart';
import 'package:ideas_desktop/view/end-of-day/tables/gift_report_table.dart';
import 'package:ideas_desktop/view/multi_select/multi_select_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../model/end_of_day_cancel_report_model.dart';
import '../../model/end_of_day_check_account_report_model.dart';
import '../../model/end_of_day_check_report_model.dart';
import '../../model/end_of_day_sales_report.dart';
import '../../model/end_of_day_summary_model.dart';
import '../../model/end_of_day_unpayable_report_model.dart';
import '../../service/end_of_day/end_of_day_service.dart';
import '../_utility/msg_dialog.dart';
import '../_utility/sync_dialog/sync_dialog_view.dart';
import 'component/end_of_day_stepper_view.dart';
import 'tables/cancel_report_table.dart';
import 'tables/check_account_receiving_table.dart';
import 'tables/check_account_report_table.dart';
import 'tables/check_report_table.dart';
import 'tables/sales_report_table.dart';
import 'tables/unpayable_check_report.dart';
import 'tables/unpayable_product_report.dart';

enum EndOfDayReportEnum {
  SUMMARY,
  CHECK,
  SALE,
  UNPAYABLE,
  CANCEL,
  CHECK_ACOOUNT,
  LOG,
  DETAIL,
  OKC_POS,
  GIFT,
}

class EndOfDayController extends BaseController {
  late EndOfDayService endOfDayService = Get.find();
  late ServerService serverService = Get.find();
  late StockService stockService = Get.find();
  late BranchService branchService = Get.find();
  late EftPosService eftPosService = Get.find();
  final DateRangePickerController dateCtrl = DateRangePickerController();
  Rx<EndOfDaySummaryReportModel?> summaryReport =
      Rx<EndOfDaySummaryReportModel?>(null);
  Rx<EndOfDayCheckAccountReportModel?> checkAccountReport =
      Rx<EndOfDayCheckAccountReportModel?>(null);
  Rx<CheckReportDataSource?> checkReportDataSource =
      Rx<CheckReportDataSource?>(null);
  Rx<LogReportDataSource?> logReportDataSource = Rx<LogReportDataSource?>(null);
  Rx<SaleReportDataSource?> saleReportDataSource =
      Rx<SaleReportDataSource?>(null);
  Rx<EndOfDayUnpayableReportModel?> unpayableReport =
      Rx<EndOfDayUnpayableReportModel?>(null);
  Rx<UnpayableProductReportDataSource?> unpayableProductsDataSource =
      Rx<UnpayableProductReportDataSource?>(null);
  Rx<UnpayableCheckReportDataSource?> unpayableChecksDataSource =
      Rx<UnpayableCheckReportDataSource?>(null);
  Rx<CheckAccountReportDataSource?> checkAccountReportDataSource =
      Rx<CheckAccountReportDataSource?>(null);
  Rx<CheckAccountReceivingReportDataSource?>
      checkAccountReceivingReportDataSource =
      Rx<CheckAccountReceivingReportDataSource?>(null);
  Rx<CancelReportTableDataSource?> cancelReportDataSource =
      Rx<CancelReportTableDataSource?>(null);
  Rx<GiftReportTableDataSource?> giftReportDataSource =
      Rx<GiftReportTableDataSource?>(null);
  Rx<EftPosModel?> selectedPoss = Rx<EftPosModel?>(null);

  RxList<EndOfDayHourlySaleModel> hourlySaleModel = RxList([]);
  RxList<EndOfDayCheckReportModel> checkReport = RxList([]);
  RxList<EndOfDayLogModel> logReport = RxList([]);
  RxList<EndOfDaySaleReportModel> saleReport = RxList([]);
  RxList<EndOfDayCancelModel> cancelReport = RxList([]);
  RxList<EndOfDayCancelModel> giftReport = RxList([]);
  RxList<String> categories = RxList([]);
  RxList<String> selectedCategories = RxList([]);
  RxList<DateTime> specialDates = RxList([]);
  RxList<EftPosModel> poss = RxList([]);
  RxList<OkcDeptModel> departments = RxList([]);
  RxList<TextEditingController> controllers = RxList([]);

  RxBool paymentStart = RxBool(false);

  RxString header = RxString("");
  Rx<EndOfDayReportEnum> selectedReportEnum =
      Rx<EndOfDayReportEnum>(EndOfDayReportEnum.SUMMARY);
  RxInt tabIndex = RxInt(0);
  RxInt unpayableTabIndex = RxInt(0);
  RxInt checkAccountTabIndex = RxInt(0);
  RxBool showCalender = RxBool(false);
  RxBool initFinished = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    setHeaderText();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getEndOfDayDates();
      await getSummaryReport();
      finishInit();
    });
  }

  finishInit() {
    initFinished(true);
  }

  Future getEndOfDayDates() async {
    var res = await endOfDayService.getEndOfDayDates(authStore.user!.branchId!);
    if (res != null) {
      for (var item in res) {
        specialDates.add(item.value!);
      }
    }
    specialDates.refresh();
  }

  Future getSummaryReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    summaryReport(await endOfDayService
        .getEndOfDaySummaryReport(authStore.user!.branchId!));

    hourlySaleModel(await endOfDayService
        .getEndOfDayHourSaleReport(authStore.user!.branchId!));

    EasyLoading.dismiss();
  }

  Future getEndOfDayPastSummaryReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await endOfDayService.getEndOfDayPastSummaryReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!);

    var res2 = await endOfDayService.getEndOfDayPastHourSaleReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!);
    if (res != null) summaryReport(res);
    if (res2 != null) hourlySaleModel(res2);
    EasyLoading.dismiss();
  }

  Future getCheckReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkReport(await endOfDayService
        .getEndOfDayCheckReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    checkReportDataSource(CheckReportDataSource(checks: checkReport));
  }

  Future getGiftReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    giftReport(
        await endOfDayService.getEndOfDayGiftReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    giftReportDataSource(GiftReportTableDataSource(giftReport: giftReport));
  }

  Future getEndOfDayPastCheckReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkReport(await endOfDayService.getEndOfDayPastCheckReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    checkReportDataSource(CheckReportDataSource(checks: checkReport));
  }

  Future getLogs() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    logReport(
        await endOfDayService.getEndOfDayLogReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    logReportDataSource(LogReportDataSource(logs: logReport));
  }

  Future getPastLogs() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    logReport(await endOfDayService.getEndOfDayPastLogReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    logReportDataSource(LogReportDataSource(logs: logReport));
  }

  Future getCancelReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    cancelReport(await endOfDayService
        .getEndOfDayCancelReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    cancelReportDataSource(
        CancelReportTableDataSource(cancelReport: cancelReport));
  }

  Future getPastCancelReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    cancelReport(await endOfDayService.getEndOfDayPastCancelReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    cancelReportDataSource(
        CancelReportTableDataSource(cancelReport: cancelReport));
  }

  Future getEndOfDayPastGiftReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    giftReport(await endOfDayService.getEndOfDayPastGiftReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    giftReportDataSource(GiftReportTableDataSource(giftReport: giftReport));
  }

  Future getCheckAccountReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkAccountReport(await endOfDayService
        .getEndOfDayCheckAccountReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    checkAccountReportDataSource(CheckAccountReportDataSource(
        checkAccountReport: checkAccountReport.value!.checks!));
    checkAccountReceivingReportDataSource(CheckAccountReceivingReportDataSource(
        checkAccountReceivingReport: checkAccountReport.value!.receivings!));
  }

  Future getPastCheckAccountReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkAccountReport(await endOfDayService.getEndOfDayPastCheckAccountReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    checkAccountReportDataSource(CheckAccountReportDataSource(
        checkAccountReport: checkAccountReport.value!.checks!));
    checkAccountReceivingReportDataSource(CheckAccountReceivingReportDataSource(
        checkAccountReceivingReport: checkAccountReport.value!.receivings!));
  }

  Future getUnpayableReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    unpayableReport(await endOfDayService
        .getEndOfDayUnpayableReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    unpayableProductsDataSource(UnpayableProductReportDataSource(
        products: unpayableReport.value!.checkMenuItems!));
    unpayableChecksDataSource(UnpayableCheckReportDataSource(
        checks: unpayableReport.value!.unpayableChecks!));
  }

  Future getPastUnpayableReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    unpayableReport(await endOfDayService.getEndOfDayPastUnpayableReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    unpayableProductsDataSource(UnpayableProductReportDataSource(
        products: unpayableReport.value!.checkMenuItems!));
    unpayableChecksDataSource(UnpayableCheckReportDataSource(
        checks: unpayableReport.value!.unpayableChecks!));
  }

  Future getSaleReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    saleReport(
        await endOfDayService.getEndOfDaySaleReport(authStore.user!.branchId!));
    EasyLoading.dismiss();

    categories([]);
    selectedCategories([]);
    for (var item in saleReport) {
      if (!categories.contains(item.categoryName)) {
        categories.add(item.categoryName!);
        selectedCategories.add(item.categoryName!);
      }
    }
    saleReportDataSource(SaleReportDataSource(sales: saleReport));
    categories.refresh();
    selectedCategories.refresh();
  }

  Future getPastSaleReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    saleReport(await endOfDayService.getEndOfDayPastSaleReport(
        authStore.user!.branchId!, dateCtrl.selectedDate!));
    EasyLoading.dismiss();

    categories([]);
    selectedCategories([]);
    for (var item in saleReport) {
      if (!categories.contains(item.categoryName)) {
        categories.add(item.categoryName!);
        selectedCategories.add(item.categoryName!);
      }
    }
    saleReportDataSource(SaleReportDataSource(sales: saleReport));
    categories.refresh();
    selectedCategories.refresh();
  }

  void addSelectedCategory(List<Object?> categories) {
    selectedCategories([]);
    for (var item in categories) {
      selectedCategories.add(item.toString());
    }
    selectedCategories.refresh();
    filterSalesReportDataSource();
  }

  void changeTabIndex(int index) {
    tabIndex(index);
    if (dateCtrl.selectedDate == null) {
      if (index == 0) getSummaryReport();
      if (index == 1) getCheckReport();
      if (index == 2) getSaleReport();
      if (index == 3) getUnpayableReport();
      if (index == 4) getCancelReport();
      if (index == 5) getCheckAccountReport();
      if (index == 6) getLogs();
    } else {
      if (index == 0) getEndOfDayPastSummaryReport();
      if (index == 1) getEndOfDayPastCheckReport();
      if (index == 2) getPastSaleReport();
      if (index == 3) getPastUnpayableReport();
      if (index == 4) getPastCancelReport();
      if (index == 5) getPastCheckAccountReport();
      if (index == 6) getPastLogs();
    }
  }

  void changeUnpayableTabIndex(int index) {
    unpayableTabIndex(index);
  }

  void changeCheckAccountTabIndex(int index) {
    checkAccountTabIndex(index);
  }

  filterSalesReportDataSource() {
    saleReportDataSource(SaleReportDataSource(
        sales: saleReport
            .where(
                (element) => selectedCategories.contains(element.categoryName))
            .toList()));
  }

  Future showMultiSelect() async {
    final items = <MultiSelectDialogItem<String>>[];

    for (var item in categories) {
      items.add(MultiSelectDialogItem(item, item));
    }

    final selectedValues =
        await Get.dialog(const MultiSelectDialog(), arguments: [
      items,
      selectedCategories,
    ]);

    if (selectedValues != null) {
      selectedCategories([]);
      for (var item in selectedValues) {
        selectedCategories.add(item);
      }
      filterSalesReportDataSource();
    }
  }

  Future checkServer() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await serverService.checkServerChanges(authStore.user!.branchId!);
    EasyLoading.dismiss();
    if (res != null && res.message != null) {
      await Get.dialog(
        barrierDismissible: res.message!.msgTypeId != 2,
        MsgDialog(msg: res.message!),
      );
    }
    if (res != null && res.changeCount! > 0) {
      await Get.dialog(
        barrierDismissible: false,
        const SyncDialog(),
      );
    }
  }

  Future openEndOfDayStepperDialog() async {
    await checkServer();
    await getCheckReport();
    bool canEndOfDay = true;
    int checkId = 0;
    for (var check in checkReport) {
      if (!(check.verification == 0 ||
          check.verification == check.checkAccountAmount)) {
        canEndOfDay = false;
        checkId = check.checkId!;
        break;
      }
    }
    if (canEndOfDay) {
      var res = await Get.dialog(
        EndOfDayStepperPage(),
      );
      if (res != null && res == true) {
        Get.back();
        await calculateStocks();
      }
    } else {
      showSnackbarError(
          '$checkId numaralı adisyon hatalı durumda. Lütfen adisyonlar kısmından kontrol ediniz!');
    }
  }

  Future printEndOfDaySummaryReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await endOfDayService.printEndOfDaySummaryReport(
        authStore.user!.branchId!, dateCtrl.selectedDate);
    EasyLoading.dismiss();
  }

  Future sendEndOfDaysToServer() async {
    var res = await openYesNoDialog(
        'Eski gün sonlarını sunucuya atmak istediğinizden emin misiniz?');

    if (res == true) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await endOfDayService
          .sendEndOfDaysToServer(authStore.user!.branchId!);
      EasyLoading.dismiss();

      if (result != null) {
        if (result.value! > 0) {
          showSnackbarError(
              '${result.value} adet gün sonu, sunucuya başarıyla aktarıldı.');
        } else {
          showSnackbarError('Sunucuya aktarılmamış bir gün sonu bulunamadı.');
        }

        await calculateStocks();
      }
    } else {
      showSnackbarError('İşlem başarısız!');
    }
  }

  Future calculateStocks() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );

    var ends = await endOfDayService
        .getNotCalculatedEndOfDays(authStore.user!.branchId!);

    if (ends != null) {
      for (var i = 0; i < ends.length; i++) {
        var end = ends[i];
        var res = await stockService.calculateEndOfDayStocks(
            end.endOfDayId!, end.branchId!);
        if (res == null || res.value! < 0) {
          showSnackbarError('Stok hesaplanırken hata oluştu!');
          break;
        }
      }
    }

    var serverBranchId =
        (await branchService.getServerBranchId(authStore.user!.branchId!))!
            .value;

    await stockService.calculateStockCosts(serverBranchId!);

    EasyLoading.dismiss();
  }

  openSelectReportDialog() {
    Get.dialog(
      const SelectReportPage(),
      arguments: dateCtrl.selectedDate,
    );
  }

  changeSelectedReport(EndOfDayReportEnum rep) async {
    await getReport(rep);
    selectedReportEnum(rep);
    setHeaderText();
  }

  getReport(EndOfDayReportEnum rep) async {
    if (dateCtrl.selectedDate == null) {
      switch (rep) {
        case EndOfDayReportEnum.SUMMARY:
          await getSummaryReport();
          break;
        case EndOfDayReportEnum.CHECK:
          await getCheckReport();
          break;
        case EndOfDayReportEnum.CANCEL:
          await getCancelReport();
          break;
        case EndOfDayReportEnum.CHECK_ACOOUNT:
          await getCheckAccountReport();
          break;
        case EndOfDayReportEnum.LOG:
          await getLogs();
          break;
        case EndOfDayReportEnum.SALE:
          await getSaleReport();
          break;
        case EndOfDayReportEnum.UNPAYABLE:
          await getUnpayableReport();
          break;
        case EndOfDayReportEnum.DETAIL:
          await getSummaryReport();
          break;
        case EndOfDayReportEnum.OKC_POS:
          await getPosAndOkcDept();
          break;
        case EndOfDayReportEnum.GIFT:
          await getGiftReport();
          break;
      }
    } else {
      switch (rep) {
        case EndOfDayReportEnum.SUMMARY:
          await getEndOfDayPastSummaryReport();
          break;
        case EndOfDayReportEnum.CHECK:
          await getEndOfDayPastCheckReport();
          break;
        case EndOfDayReportEnum.CANCEL:
          await getPastCancelReport();
          break;
        case EndOfDayReportEnum.CHECK_ACOOUNT:
          await getPastCheckAccountReport();
          break;
        case EndOfDayReportEnum.LOG:
          await getPastLogs();
          break;
        case EndOfDayReportEnum.SALE:
          await getPastSaleReport();
          break;
        case EndOfDayReportEnum.UNPAYABLE:
          await getPastUnpayableReport();
          break;
        case EndOfDayReportEnum.DETAIL:
          await getEndOfDayPastSummaryReport();
          break;
        case EndOfDayReportEnum.OKC_POS:
          await getPosAndOkcDept();
          break;
        case EndOfDayReportEnum.GIFT:
          await getEndOfDayPastGiftReport();
          break;
      }
    }
  }

  setHeaderText() {
    switch (selectedReportEnum.value) {
      case EndOfDayReportEnum.SUMMARY:
        header("Özet");
        break;
      case EndOfDayReportEnum.CHECK:
        header("Adisyon");
        break;
      case EndOfDayReportEnum.CANCEL:
        header("İptal");
        break;
      case EndOfDayReportEnum.CHECK_ACOOUNT:
        header("Cari Hesaplar");
        break;
      case EndOfDayReportEnum.LOG:
        header("Loglar");
        break;
      case EndOfDayReportEnum.SALE:
        header("Satış");
        break;
      case EndOfDayReportEnum.UNPAYABLE:
        header("Ödenmez");
        break;
      case EndOfDayReportEnum.DETAIL:
        header("Detay");
        break;
      case EndOfDayReportEnum.OKC_POS:
        header("OKC Pos");
        break;
      case EndOfDayReportEnum.GIFT:
        header("İkram");
        break;
    }
  }

  getPosAndOkcDept() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await eftPosService.getEftPoss(authStore.user!.branchId!);
    if (res != null && res.isNotEmpty) {
      poss(res);
      changeSelectedPos(poss[0]);
    }
    if (selectedPoss.value != null) {
      var res2 =
          await eftPosService.getDepartments(selectedPoss.value!.eftPosId!);
      if (res2 != null) {
        departments(res2);
        controllers([]);
        for (var i = 0; i < departments.length; i++) {
          controllers.add(TextEditingController());
        }
      }
    }
    EasyLoading.dismiss();
  }

  voidReceipt() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.voidReceipt(selectedPoss.value!.eftPosId!);
    EasyLoading.dismiss();
  }

  closeDoc() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.closeReceipt(selectedPoss.value!.eftPosId!, null, 0, 0);
    EasyLoading.dismiss();
  }

  xReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.xReport(selectedPoss.value!.eftPosId!);
    EasyLoading.dismiss();
  }

  ekuReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.ekuReport(selectedPoss.value!.eftPosId!);
    EasyLoading.dismiss();
  }

  voidEftPayment() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.voidEftPayment(selectedPoss.value!.eftPosId!);
    EasyLoading.dismiss();
  }

  zReport() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    await eftPosService.zReport(selectedPoss.value!.eftPosId!);
    EasyLoading.dismiss();
  }

  changeStartPayment(bool start) {
    paymentStart(start);
  }

  makePayment() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    changeStartPayment(true);
    var connectRes = await eftPosService.connectEftPos(
        authStore.user!.branchId!, selectedPoss.value!.eftPosId);
    if (connectRes == null) {
      EasyLoading.dismiss();
      return;
    }

    var startReceipeRes =
        await eftPosService.startReceipt(selectedPoss.value!.eftPosId!);
    if (startReceipeRes == null) {
      EasyLoading.dismiss();
      return;
    }

    List<DeptSellInput> inp = [];
    for (var i = 0; i < controllers.length; i++) {
      var controller = controllers[i];
      var dept = departments[i];
      var amount = controller.text.getDouble;
      if (amount == null || amount == 0) continue;
      inp.add(DeptSellInput(authStore.user!.branchId,
          selectedPoss.value!.eftPosId, dept.deptId, dept.deptName, amount, 0));
    }

    var saleRes = await eftPosService.deptSell(inp);
    if (saleRes == null) {
      EasyLoading.dismiss();
      return;
    }

    var closeRes = await eftPosService.closeReceipt(
        selectedPoss.value!.eftPosId!, null, 0, 0);
    if (closeRes == null) {
      EasyLoading.dismiss();
      return;
    }
    changeStartPayment(false);
    EasyLoading.dismiss();
  }

  changeSelectedPos(EftPosModel pos) {
    selectedPoss(pos);
  }

  void changeShowCalender() {
    showCalender(!showCalender.value);
    if (!showCalender.value) {
      dateCtrl.selectedDate = null;
      changeSelectedReport(selectedReportEnum.value);
    }
  }
}
