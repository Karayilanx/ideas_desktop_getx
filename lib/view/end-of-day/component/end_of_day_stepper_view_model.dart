import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../locale_keys_enum.dart';
import '../../../model/check_model.dart';
import '../../../model/end_of_day_model.dart';
import '../../../service/end_of_day/end_of_day_service.dart';

class EndOfDayStepperController extends BaseController {
  EndOfDayService endOfDayService = Get.find();
  final DateRangePickerController dateCtrl = DateRangePickerController();
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

  Rx<CheckCountModel?> checkCount = Rx<CheckCountModel?>(null);
  RxInt stepIndex = RxInt(0);
  Rx<CheckDetailsModel?> firstCheck = Rx<CheckDetailsModel?>(null);
  RxBool serverConnectionSuccess = RxBool(false);
  RxList<DateTime> specialDates = RxList([]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFirstCheck();
      getEndOfDayDates();
      getOpenChecksCount();

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

  Future getFirstCheck() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res =
        await endOfDayService.getFirstCheckOfTheDay(authStore.user!.branchId!);
    EasyLoading.dismiss();
    if (res != null) {
      firstCheck(res);
    }
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

  Future getOpenChecksCount() async {
    var res =
        await endOfDayService.getOpenCheckCounts(authStore.user!.branchId!);
    if (res != null) checkCount(res);
  }

  Future tryServerConnection() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res =
        await endOfDayService.tryServerConnection(authStore.user!.branchId!);
    EasyLoading.dismiss();
    if (res != null) {
      serverConnectionSuccess(true);
      await sendEndOfDaysToServer();
    } else {
      serverConnectionSuccess(false);
    }
  }

  stepForward() {
    stepIndex(stepIndex.value + 1);
  }

  stepBack() {
    stepIndex(stepIndex.value - 1);
  }

  void selectReport(PrintableReport rep) {
    rep.isSelected = !rep.isSelected;
    reportsLeft.refresh();
    reportsRight.refresh();
  }

  Future endDay() async {
    if (checkCount.value!.getir! > 0 || checkCount.value!.yemeksepeti! > 0) {
      showSnackbarError(
          "Gün sonu almak için Yemeksepeti ve Getir siparişlerini tamamlayın.\nYemeksepeti Açık Sipariş:${checkCount.value!.yemeksepeti!}\nGetir Açık Sipariş:${checkCount.value!.getir!}");
    } else {
      var confirm = await openYesNoDialog(
          '${DateFormat('dd-MMMM-yyyy').format(dateCtrl.selectedDate!)} gününe gün sonu almak istediğinize emin misiniz?');
      if (confirm) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await endOfDayService.endDay(
            authStore.user!.branchId!, dateCtrl.selectedDate!);
        EasyLoading.dismiss();

        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        if (reportsLeft[0].isSelected) {
          await endOfDayService.printEndOfDaySummaryReport(
              authStore.user!.branchId!, dateCtrl.selectedDate);
        }
        if (reportsLeft[1].isSelected) {
          await endOfDayService.printEndOfDayCheckReport(
              authStore.user!.branchId!, dateCtrl.selectedDate);
        }
        if (reportsLeft[2].isSelected) {
          await endOfDayService.printEndOfDaySaleReport(
              authStore.user!.branchId!, dateCtrl.selectedDate);
        }
        if (reportsLeft[3].isSelected) {
          await endOfDayService.printEndOfDayCategoryReport(
              authStore.user!.branchId!, dateCtrl.selectedDate);
        }

        await localeManager.setBoolValue(
            PreferencesKeys.PRINT_ENDOFDAY_SUMMARY_REPORT,
            reportsLeft[0].isSelected);
        await localeManager.setBoolValue(
            PreferencesKeys.PRINT_ENDOFDAY_CHECK_REPORT,
            reportsLeft[1].isSelected);
        await localeManager.setBoolValue(
            PreferencesKeys.PRINT_ENDOFDAY_SALE_REPORT,
            reportsLeft[2].isSelected);
        await localeManager.setBoolValue(
            PreferencesKeys.PRINT_ENDOFDAY_CATEGORY_REPORT,
            reportsLeft[3].isSelected);
        EasyLoading.dismiss();

        if (res != null) {
          stepForward();
          tryServerConnection();
        }
      }
    }
  }

  Future sendEndOfDaysToServer() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res =
        await endOfDayService.sendEndOfDaysToServer(authStore.user!.branchId!);
    EasyLoading.dismiss();
    if (res != null) {
      await showDefaultDialog('Başarılı', 'Veriler başarıyla aktarıldı');
      Get.back(result: true);
    }
  }
}

class PrintableReport {
  final int reportId;
  bool isSelected;
  final String reportName;

  PrintableReport({
    this.isSelected = false,
    required this.reportId,
    required this.reportName,
  });
}
