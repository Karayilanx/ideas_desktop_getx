import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/service/end_of_day/end_of_day_service.dart';
import 'package:ideas_desktop/view/end-of-day/component/end_of_day_stepper_view_model.dart';

import '../../../locale_keys_enum.dart';

class SelectReportController extends BaseController {
  EndOfDayService endOfDayService = Get.find();
  DateTime? selectedDate = Get.arguments;
  RxBool loading = RxBool(false);
  RxList<PrintableReport> reportsLeft = RxList<PrintableReport>([
    PrintableReport(reportId: 0, reportName: 'Özet Rapor'),
    PrintableReport(reportId: 1, reportName: 'Adisyon Listesi'),
    PrintableReport(reportId: 2, reportName: 'Satış Detayları'),
    PrintableReport(reportId: 3, reportName: 'Kategori Detayları'),
    // PrintableReport(reportId: 3, reportName: 'Satış Özeti'),
    // PrintableReport(reportId: 4, reportName: 'Masraflar'),
    // PrintableReport(reportId: 5, reportName: 'İptaller ve Zayiler'),
  ]);

  RxList<PrintableReport> reportsRight = RxList([
    // PrintableReport(reportId: 6, reportName: 'Ödenmez ve İkram Detayları'),
    // PrintableReport(reportId: 7, reportName: 'Ödenmez ve İkram Özeti'),
    // PrintableReport(reportId: 8, reportName: 'Ödenmez ve İkram Hesap Listesi'),
    // PrintableReport(reportId: 9, reportName: 'Cari Hesap Listesi'),
    // PrintableReport(reportId: 10, reportName: 'Cari Tahsilatları'),
    // PrintableReport(
    //     reportId: 11, reportName: 'Tüm Çıkışlar (Satış + Ödenmez + Zayi)'),
  ]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool print = false;
      // SUMMARY REPORT
      print = localeManager
          .getBoolValue(PreferencesKeys.PRINT_ENDOFDAY_SUMMARY_REPORT);
      if (print) {
        selectReport(reportsLeft[0]);
      }
      // CHECK REPORT
      print = localeManager
          .getBoolValue(PreferencesKeys.PRINT_ENDOFDAY_CHECK_REPORT);
      if (print) {
        selectReport(reportsLeft[1]);
      }
      // SALE REPORT
      print = localeManager
          .getBoolValue(PreferencesKeys.PRINT_ENDOFDAY_SALE_REPORT);
      if (print) {
        selectReport(reportsLeft[2]);
      }
      // CATEGORY REPORT
      print = localeManager
          .getBoolValue(PreferencesKeys.PRINT_ENDOFDAY_CATEGORY_REPORT);
      if (print) {
        selectReport(reportsLeft[3]);
      }
    });
  }

  void changeLoading(bool val) {
    loading(val);
  }

  void selectReport(PrintableReport rep) {
    rep.isSelected = !rep.isSelected;
    reportsLeft.refresh();
    reportsRight.refresh();
  }

  print() async {
    loading(true);
    if (reportsLeft[0].isSelected) {
      await endOfDayService.printEndOfDaySummaryReport(
          authStore.user!.branchId!, selectedDate);
    }
    if (reportsLeft[1].isSelected) {
      await endOfDayService.printEndOfDayCheckReport(
          authStore.user!.branchId!, selectedDate);
    }
    if (reportsLeft[2].isSelected) {
      await endOfDayService.printEndOfDaySaleReport(
          authStore.user!.branchId!, selectedDate);
    }
    if (reportsLeft[3].isSelected) {
      await endOfDayService.printEndOfDayCategoryReport(
          authStore.user!.branchId!, selectedDate);
    }
    await localeManager.setBoolValue(
        PreferencesKeys.PRINT_ENDOFDAY_SUMMARY_REPORT,
        reportsLeft[0].isSelected);
    await localeManager.setBoolValue(
        PreferencesKeys.PRINT_ENDOFDAY_CHECK_REPORT, reportsLeft[1].isSelected);
    await localeManager.setBoolValue(
        PreferencesKeys.PRINT_ENDOFDAY_SALE_REPORT, reportsLeft[2].isSelected);
    await localeManager.setBoolValue(
        PreferencesKeys.PRINT_ENDOFDAY_CATEGORY_REPORT,
        reportsLeft[3].isSelected);
    loading(false);
    Get.back();
  }
}
