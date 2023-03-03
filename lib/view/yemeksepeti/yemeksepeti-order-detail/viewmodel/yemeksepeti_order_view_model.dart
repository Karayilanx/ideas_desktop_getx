import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/view/order-detail/navigation/table_detail_navigation_args.dart';
import '../../../../model/check_model.dart';
import '../../../../model/delivery_model.dart';
import '../../../../model/printer_model.dart';
import '../../../../model/yemeksepeti_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/printer/printer_service.dart';
import '../../../../service/yemeksepeti/yemeksepeti_service.dart';
import '../../../order-detail/model/order_detail_model.dart';
import '../../../order-detail/view/order_detail_view.dart';
import '../../../select-multi-printer/select_multi_printer_view.dart';

class YemeksepetiOrderController extends BaseController {
  final String? yemeksepetiId = Get.arguments;
  Rx<YemeksepetiCheckDetailsModel?> yemeksepetiCheck =
      Rx<YemeksepetiCheckDetailsModel?>(null);
  RxList<GroupedCheckItem?> groupedItems = RxList([]);

  YemeksepetiService yemeksepetiService = Get.find();
  PrinterService printerService = Get.put(PrinterService());
  CheckService checkService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getGetirOrderDetails();
    });
  }

  Future getGetirOrderDetails() async {
    if (yemeksepetiId != null) {
      yemeksepetiCheck(await yemeksepetiService.getYemeksepetiOrderDetails(
          authStore.user!.branchId!, yemeksepetiId!));
      groupedItems(getGroupedMenuItems(yemeksepetiCheck.value!.basketItems!));
    }
  }

  Future verifyYemeksepetiOrder() async {
    await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId!, 1, authStore.user!.terminalUserId!);
    await getGetirOrderDetails();
    closePage();
  }

  Future prepareYemeksepetiOrder() async {
    await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId!, 4, authStore.user!.terminalUserId!);
    await getGetirOrderDetails();
    closePage();
  }

  Future deliverYemeksepetiOrder() async {
    await yemeksepetiService.updateOrder(authStore.user!.branchId!,
        yemeksepetiId!, 5, authStore.user!.terminalUserId!);
    closePage();
  }

  void navigateToDeliveryOrder(int? checkId, bool isIntegration) async {
    if (isIntegration) {
      await Get.dialog(const OrderDetailView(),
          arguments: TableDetailArguments(
              tableId: -1,
              checkId: checkId,
              type: OrderDetailPageType.DELIVERY,
              isIntegration: true));
    } else {
      await Get.dialog(const OrderDetailView(),
          arguments: TableDetailArguments(
              tableId: -1,
              checkId: checkId,
              type: OrderDetailPageType.DELIVERY,
              isIntegration: false));
    }
    closePage();
  }

  Future makeCheckPayment() async {
    CheckPaymentModel input = CheckPaymentModel(
      checkId: yemeksepetiCheck.value!.checkId,
      isMenuItemBased: false,
      paymentTypeId: getCheckPaymentType().index,
      terminalUserId: authStore.user!.terminalUserId,
      branchId: authStore.user!.branchId!,
    );
    input.amount = yemeksepetiCheck.value!.payments!.remainingAmount;
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await checkService.makeCheckPayment(input);
    EasyLoading.dismiss();
    if (res != null) {
      closePage();
    }
  }

  Future openPaymentTypePopup() async {
    await Get.dialog(SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
            onPressed: () {
              makeCheckPayment();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.context!.theme.primaryColor,
            ),
            child: const Text('Siparişi Tamamla',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
            onPressed: () async {
              await Get.dialog(const OrderDetailView(),
                  arguments: TableDetailArguments(
                      tableId: -1,
                      checkId: yemeksepetiCheck.value!.checkId,
                      type: OrderDetailPageType.DELIVERY,
                      isIntegration: true));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.context!.theme.primaryColor,
            ),
            child: const Text('Ödeme Şeklini Değiştir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                )),
          ),
        )
      ],
    ));
  }

  CheckPaymentTypeEnum getCheckPaymentType() {
    switch (yemeksepetiCheck.value!.yemeksepetiPaymentTypeId) {
      case 3:
        return CheckPaymentTypeEnum.CreditCart;
      case 4:
        return CheckPaymentTypeEnum.Cash;
      default:
        return CheckPaymentTypeEnum.Other;
    }
  }

  String getTitleText() {
    switch (yemeksepetiCheck.value!.status) {
      case 0:
        return 'Sipariş onayı';
      case 1:
        return 'Siparişi yola çıkar';
      case 4:
        return 'Tamamla';
      case 5:
        if (yemeksepetiCheck.value!.deliveryStatusTypeId ==
            DeliveryStatusTypeEnum.Delivered.index) {
          return 'Ödeme Al';
        } else {
          return 'Teslim Edildi';
        }
      case 2:
        return 'Restoran tarafından iptal edildi';
      case 3:
        return 'Teknik nedenlerden iptal edildi';
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
    return yemeksepetiCheck.value!.paymentTypeString!;
  }

  Future openDeleteYemeksepetiOrderDialog() async {
    var dialogRes = await openYesNoDialog(
        'Siparişi hatalı olduğu için sistemden SİLMEK istediğinizden emin misiniz? Bu işlemin geri dönüşü YOKTUR.');

    if (dialogRes) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await yemeksepetiService.deleteYemeksepetiOrder(yemeksepetiId!);
      EasyLoading.dismiss();
      if (res != null && res.value == 1) {
        await showDefaultDialog(
            'Başarılı', 'Sipariş başarıyla sistemden kaldırıldı');
        Get.back();
      }
    }
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
        await printerService.printYemeksepeti(
            yemeksepetiId!, printer.printerName!, authStore.user!.branchId!);
      }
      EasyLoading.dismiss();
    }
  }

  closePage() {
    Get.back(result: null);
  }
}
