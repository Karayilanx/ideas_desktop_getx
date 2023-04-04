import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';

import 'multi_select_view.dart';

class MultiSelectController<T> extends BaseController {
  RxList<MultiSelectDialogItem<T>> items = RxList<MultiSelectDialogItem<T>>(
      Get.arguments[0] as List<MultiSelectDialogItem<T>>);
  RxList<T> initialSelectedValues = RxList<T>(Get.arguments[1] as List<T>);
  RxList<T> selectedValues = RxList([]);

  @override
  void onInit() {
    super.onInit();

    selectedValues.addAll(initialSelectedValues);
  }

  void onItemCheckedChange(T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    selectedValues.refresh();
  }

  void onCancelTap() {
    Get.back();
  }

  void onSubmitTap() {
    Get.back(result: selectedValues);
  }
}
