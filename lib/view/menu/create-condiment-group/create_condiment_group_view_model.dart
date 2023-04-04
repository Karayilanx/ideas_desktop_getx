import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/menu/create-condiment/create_condiment_view.dart';

class CreateCondimentGroupController extends BaseController {
  MenuService menuService = Get.find();
  ServerService serverService = Get.find();

  TextEditingController searchCondimentCtrl = TextEditingController();
  TextEditingController searchMenuItemCtrl = TextEditingController();
  TextEditingController searchPrerequisteCtrl = TextEditingController();
  final TextEditingController nameTrController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController minCountController = TextEditingController();
  final TextEditingController maxCountController = TextEditingController();

  RxBool isLoading = RxBool(false);
  RxBool hasPrerequisite = RxBool(false);
  Rx<CreateCondimentGroupInput> input =
      Rx<CreateCondimentGroupInput>(CreateCondimentGroupInput(
    condimentIds: [],
    condimentGroupId: -1,
    mappedMenuItemIds: [],
    menuItemIds: [],
    prerequisiteCondimentIds: [],
    isMultiple: false,
    isRequired: false,
    isPortion: false,
    maxCount: 0,
    minCount: 0,
  ));

  RxList<CondimentForEditOutput> condiments = RxList([]);
  RxList<dynamic> selectedItems = RxList([]);
  RxList<GetCategoriesMenuItemOutput> selectedMenuItems = RxList([]);
  RxList<CondimentForEditOutput> selectedPrerequisteItems = RxList([]);
  RxList<GetCategoriesOutput> categories = RxList([]);

  @override
  void onInit() {
    super.onInit();
    input.value.branchId = authStore.user!.serverBranchId!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondiments();
      await getCategories();
    });
  }

  Future getCondiments() async {
    condiments(await menuService
        .getCondimentsForEdit(authStore.user!.serverBranchId!));
  }

  Future getCategories() async {
    categories(await menuService
        .getCategoriesForNewCondimentGroup(authStore.user!.serverBranchId!));
  }

  isCondimentSelected(int id) {
    return selectedItems
        .whereType<CondimentForEditOutput>()
        .any((element) => element.condimentId == id);
  }

  addCondiment(dynamic item) {
    selectedItems.add(item);
    selectedItems.refresh();
  }

  removeCondiment(dynamic item) {
    selectedItems.remove(item);
    selectedItems.refresh();
  }

  isCondimentMenuItemSelected(int id) {
    return selectedItems
        .whereType<GetCategoriesMenuItemOutput>()
        .any((element) => element.menuItemId == id);
  }

  getSelectedCondimentNames() {
    return selectedItems.length.toString();
  }

  isMenuItemSelected(GetCategoriesMenuItemOutput id) {
    return selectedMenuItems.contains(id);
  }

  addMenuItem(GetCategoriesMenuItemOutput id) {
    selectedMenuItems.add(id);
    selectedMenuItems.refresh();
  }

  removeMenuItem(GetCategoriesMenuItemOutput id) {
    selectedMenuItems.remove(id);
    selectedMenuItems.refresh();
  }

  getSelectedMenuItemsNames() {
    return selectedMenuItems.length.toString();
  }

  getRowCount() {
    int ret = 0;
    for (var cat in categories) {
      for (var subcat in cat.menuItemSubCategories!) {
        ret += subcat.menuItems!.length;
      }
    }
    return ret;
  }

  changeIsRequired(bool vall) {
    input.update((val) {
      val!.isRequired = vall;
    });
  }

  changeIsMultiple(bool vall) {
    input.update((val) {
      val!.isMultiple = vall;
    });
  }

  changeIsPrerequiste(bool val) {
    hasPrerequisite(val);
  }

  isPrerequisteSelected(CondimentForEditOutput id) {
    return selectedPrerequisteItems.contains(id);
  }

  addPrerequiste(CondimentForEditOutput id) {
    selectedPrerequisteItems.add(id);
    selectedPrerequisteItems.refresh();
  }

  removePrerequiste(CondimentForEditOutput id) {
    selectedPrerequisteItems.remove(id);
    selectedPrerequisteItems.refresh();
  }

  getSelectedPrerequisteNames() {
    return selectedPrerequisteItems.length.toString();
  }

  createCondimentGroup() async {
    changeLoading(true);
    input.value.condimentIds = [];
    input.value.prerequisiteCondimentIds = [];
    input.value.menuItemIds = [];
    input.value.mappedMenuItemIds = [];
    input.value.nameTr = nameTrController.text;
    input.value.nameEn = nameEnController.text;
    if (input.value.isMultiple!) {
      input.value.minCount = int.parse(minCountController.text);
      input.value.maxCount = int.parse(maxCountController.text);
    }
    for (var item in selectedItems) {
      if (item is CondimentForEditOutput) {
        input.value.condimentIds!.add(item.condimentId!);
      } else if (item is GetCategoriesMenuItemOutput) {
        input.value.menuItemIds!.add(item.menuItemId!);
      }
    }

    for (var item in selectedMenuItems) {
      input.value.mappedMenuItemIds!.add(item.menuItemId!);
    }

    for (var item in selectedPrerequisteItems) {
      input.value.prerequisiteCondimentIds!.add(item.condimentId!);
    }

    var res = await menuService.createCondimentGroup(input.value);
    changeLoading(false);
    if (res != null) {
      Get.back(result: res);
    }
  }

  changeLoading(bool val) {
    isLoading(val);
  }

  openNewCondimentDialog() async {
    await Get.dialog(
      const CreateCondimentPage(),
    ).then((value) async {
      if (value != null) {
        changeLoading(true);
        await serverService.syncChanges(authStore.user!.branchId!);
        await getCondiments();
        var con = condiments
            .where((element) => element.condimentId == value.condimentId)
            .first;
        addCondiment(con);
        changeLoading(false);
      }
    });
  }
}
