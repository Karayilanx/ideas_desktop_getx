import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';

class CreateCategoryController extends BaseController {
  MenuService menuService = Get.find();

  final TextEditingController searchCatController = TextEditingController();
  final TextEditingController searchSubCatController = TextEditingController();

  final TextEditingController catNameTrController = TextEditingController();
  final TextEditingController catNameEnController = TextEditingController();
  final TextEditingController subCatNameTrController = TextEditingController();
  final TextEditingController subCatNameEnController = TextEditingController();

  RxInt selectedCategoryId = RxInt(-1);
  RxInt selectedSubCategoryId = RxInt(-1);

  RxList<MenuItemCategory> categories = RxList<MenuItemCategory>([]);
  RxBool showLoading = RxBool(false);

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
    categories(await menuService
        .getCategoriesForEdit(authStore.user!.serverBranchId!));
    categories.insert(
      0,
      MenuItemCategory(
          menuItemCategoryId: -1,
          menuItemSubCategories: null,
          nameEn: "",
          nameTr: ""),
    );
    EasyLoading.dismiss();
  }

  changeSelectedCategory(int id) {
    selectedCategoryId(id);
    MenuItemCategory selectedCat =
        categories.where((element) => element.menuItemCategoryId == id).first;

    catNameTrController.text = selectedCat.nameTr!;
    catNameEnController.text = selectedCat.nameEn!;

    if (id != -1) {
      if (!selectedCat.menuItemSubCategories!
          .any((element) => element.menuItemSubCategoryId == -1)) {
        selectedCat.menuItemSubCategories!.insert(
            0,
            MenuItemSubCategory(
              menuItemSubCategoryId: -1,
              nameEn: "",
              nameTr: "",
              isStopDefault: false,
            ));
      }
      changeSelectedSubCategory(-1);
    }
  }

  changeSelectedSubCategory(int id) {
    selectedSubCategoryId(id);
    MenuItemSubCategory selectedSubCat = categories
        .where(
            (element) => element.menuItemCategoryId == selectedCategoryId.value)
        .first
        .menuItemSubCategories!
        .where((element) => element.menuItemSubCategoryId == id)
        .first;

    subCatNameTrController.text = selectedSubCat.nameTr!;
    subCatNameEnController.text = selectedSubCat.nameEn!;
  }

  updateMenuItemCategory() async {
    var inp = AddMenuItemCategoryModel(
      branchId: authStore.user!.serverBranchId,
      menuItemCategoryId: selectedCategoryId.value,
      nameEn: catNameEnController.text,
      nameTr: catNameTrController.text,
    );

    try {
      changeLoading(true);
      var res = await menuService.updateMenuItemCategory(inp);
      if (res != null) {
        getCategoriesForEdit();
        changeSelectedCategory(-1);
      }
      changeLoading(false);
    } on Exception {
      changeLoading(false);
    }
  }

  updateMenuItemSubCategory() async {
    var inp = AddMenuItemSubCategoryModel(
      branchId: authStore.user!.serverBranchId,
      menuItemCategoryId: selectedCategoryId.value,
      nameEn: subCatNameEnController.text,
      nameTr: subCatNameTrController.text,
      isStopDefault: false,
      menuItemSubCategoryId: selectedSubCategoryId.value,
    );

    try {
      changeLoading(true);
      var res = await menuService.updateMenuItemSubCategory(inp);
      if (res != null) {
        await getCategoriesForEdit();
        changeSelectedCategory(selectedCategoryId.value);
      }
      changeLoading(false);
    } on Exception {
      changeLoading(false);
    }
  }

  changeLoading(bool val) {
    showLoading(val);
  }
}
