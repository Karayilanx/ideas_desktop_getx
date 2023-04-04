import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';

import '../../model/check_model.dart';
import '../../model/printer_model.dart';
import '../../service/printer/printer_service.dart';

class StoppedItemsController extends BaseController {
  RxList<GroupedCheckItem> selectedItems = RxList<GroupedCheckItem>([]);
  int checkId = Get.arguments[0];
  List<GroupedCheckItem> originalItems = Get.arguments[1];
  PrinterService printerService = Get.find();

  @override
  void onInit() {
    super.onInit();
    selectedItems(originalItems
        .where((element) => element.originalItem!.isStopped == true)
        .toList()
        .map((e) => GroupedCheckItem(
            totalPrice: e.totalPrice,
            name: e.name,
            originalItem: e.originalItem,
            sellUnitQuantity: e.sellUnitQuantity,
            itemCount: e.itemCount))
        .toList());
  }

  selectItem(GroupedCheckItem item) {
    selectedItems.add(item);
    selectedItems.refresh();
  }

  removeItem(GroupedCheckItem item) {
    selectedItems.removeWhere((element) =>
        element.originalItem!.menuItemId == item.originalItem!.menuItemId);
    selectedItems.refresh();
  }

  addQuantity(GroupedCheckItem item) {
    var selectedItem = selectedItems
        .where((element) =>
            element.originalItem!.menuItemId == item.originalItem!.menuItemId)
        .first;
    if (item.itemCount! > selectedItem.itemCount!) {
      selectedItem.itemCount = selectedItem.itemCount! + 1;
    }
    selectedItems.refresh();
  }

  removeQuantity(GroupedCheckItem item) {
    var selectedItem = selectedItems
        .where((element) =>
            element.originalItem!.menuItemId == item.originalItem!.menuItemId)
        .first;
    if (selectedItem.itemCount! > 1) {
      selectedItem.itemCount = selectedItem.itemCount! - 1;
    }
    selectedItems.refresh();
  }

  getQuantity(GroupedCheckItem item) {
    bool isItemInList = selectedItems
        .where((element) =>
            element.originalItem!.menuItemId == item.originalItem!.menuItemId)
        .isNotEmpty;

    if (isItemInList) {
      return selectedItems
          .where((element) =>
              element.originalItem!.menuItemId == item.originalItem!.menuItemId)
          .first
          .itemCount!
          .toStringAsFixed(0);
    } else {
      return item.itemCount!.toStringAsFixed(0);
    }
  }

  bool isItemSelected(GroupedCheckItem item) {
    for (var element in selectedItems) {
      if (element.originalItem!.menuItemId == item.originalItem!.menuItemId) {
        return true;
      }
    }
    return false;
  }

  Future printItems() async {
    var input = PrintStoppedItemsInput(
      checkId: checkId,
      items: selectedItems,
      terminalUserId: authStore.user!.terminalUserId,
      branchId: authStore.user!.branchId!,
    );
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await printerService.printStoppedItems(input);
    EasyLoading.dismiss();
    if (res != null) Get.back(result: true);
  }
}
