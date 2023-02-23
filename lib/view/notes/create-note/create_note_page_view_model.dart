import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/check_model.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';

import '../../../model/menu_model.dart';

class CreateNoteController extends BaseController {
  final GroupedCheckItem item = Get.arguments[0];
  TextEditingController noteCtrl = TextEditingController();
  RxList<int> subCategoryIds = RxList<int>([]);
  RxList<MenuItemCategory> categories = RxList<MenuItemCategory>([]);
  MenuService menuService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCategoriesForEdit();
    });
  }

  Future getCategoriesForEdit() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    categories(await menuService.getLocalCategories(authStore.user!.branchId!));

    EasyLoading.dismiss();
  }

  createMenuItemNote() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );

    CreateMenuItemNoteInput input = CreateMenuItemNoteInput(
      branchId: authStore.user!.branchId!,
      note: noteCtrl.text,
      subCategoryIds: subCategoryIds,
    );

    var res = await menuService.createMenuItemNote(input);
    EasyLoading.dismiss();

    if (res != null) Get.back();
  }

  isSubCategorySelected(int id) {
    return subCategoryIds.contains(id);
  }

  addSubCategory(int id) {
    subCategoryIds.add(id);
    subCategoryIds.refresh();
  }

  removeSubCategory(int id) {
    subCategoryIds.remove(id);
    subCategoryIds.refresh();
  }

  getSubCategoriesCount() {
    int count = 0;
    for (var element in categories) {
      count += element.menuItemSubCategories!.length;
    }
    count += categories.length;
    return count;
  }
}
