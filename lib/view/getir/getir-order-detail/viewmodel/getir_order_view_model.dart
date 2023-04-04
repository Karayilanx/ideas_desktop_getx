import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/service/getir_service.dart';

import '../../../../model/check_model.dart';
import '../../../../model/delivery_model.dart';
import '../../../../model/getir_model.dart';
import '../../../../model/printer_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/printer/printer_service.dart';
import '../../../select-multi-printer/select_multi_printer_view.dart';

class GetirOrderController extends BaseController {
  final String? getirId = Get.arguments;
  Rx<GetirCheckDetailsModel?> getirCheck = Rx<GetirCheckDetailsModel?>(null);
  RxList<GroupedCheckItem> groupedItems = RxList([]);

  GetirService getirService = Get.find();
  CheckService checkService = Get.find();
  PrinterService printerService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGetirOrderDetails();
    });
  }

  Future getGetirOrderDetails() async {
    if (getirId != null) {
      getirCheck(await getirService.getGetirOrderDetails(
          authStore.user!.branchId!, getirId!));
      if (getirCheck.value != null) {
        groupedItems(getGroupedMenuItems(getirCheck.value!.basketItems!));
      } else {
        // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
      }
    }
  }

  CheckPaymentTypeEnum getCheckPaymentType() {
    switch (getirCheck.value!.getirPaymentTypeId) {
      case 3:
        return CheckPaymentTypeEnum.CreditCart;
      case 4:
        return CheckPaymentTypeEnum.Cash;
      default:
        return CheckPaymentTypeEnum.Other;
    }
  }

  String getTitleText() {
    switch (getirCheck.value!.status) {
      case 325:
        return 'İleri zamanlı sipariş ön onayı';
      case 350:
        return 'İleri zamanlı sipariş';
      case 400:
        return 'Sipariş onayı';
      case 500:
        if (getirCheck.value!.getirGetirsin!) {
          return 'Sipariş hazırlandı olarak işaretle';
        }
        return 'Siparişi yola çıkar';
      case 550:
        return 'Getir kuryesine teslim edildi olarak işaretle';
      case 600:
        return 'Getir kuryesine teslim edildi';
      case 700:
        return 'Tamamlandı olarak işaretle';
      case 800:
        return 'Getir kuryesi adrese ulaştı';
      case 900:
        if (getirCheck.value!.deliveryStatusTypeId ==
            DeliveryStatusTypeEnum.Delivered.index) {
          return 'Ödeme Al';
        } else {
          return 'Teslim Edildi';
        }
      case 1500:
        return 'Admin tarafından iptal edildi';
      case 1600:
        return 'Restoran tarafından iptal edildi';
      default:
        return 'Bilinmiyor';
    }
  }

  String getCondimentText(CheckMenuItemModel item) {
    String condimentsAndNotes = '';
    String groupName = '';
    bool namechanged = false;
    for (var con in item.condiments!) {
      if (con.condimentGroupName != null &&
          groupName != con.condimentGroupName) {
        groupName = con.condimentGroupName!;
        namechanged = true;
      } else {
        namechanged = false;
      }
      if (namechanged) {
        if (condimentsAndNotes.isNotEmpty) {
          condimentsAndNotes =
              condimentsAndNotes.substring(0, condimentsAndNotes.length - 2);
          condimentsAndNotes += '\n      $groupName: ';
        } else {
          condimentsAndNotes += '      $groupName: ';
        }
      }
      condimentsAndNotes += '${con.nameTr!}, ';
    }

    if (condimentsAndNotes.length > 2) {
      condimentsAndNotes =
          condimentsAndNotes.substring(0, condimentsAndNotes.length - 2);
    }
    return condimentsAndNotes;
  }

  String getPaymentText() {
    return getirCheck.value!.paymentTypeString!;
  }

  Future openPrinterDialog() async {
    var res = await Get.dialog(
      const SelectMultiPrinter(),
    );
    if (res != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      for (PrinterOutput printer in res) {
        await printerService.printGetir(
            getirId!, printer.printerName!, authStore.user!.branchId!);
      }
      EasyLoading.dismiss();
    }
  }

  closePage() {
    Get.back(result: null);
  }
}
