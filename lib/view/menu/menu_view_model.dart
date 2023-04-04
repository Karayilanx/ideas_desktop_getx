import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/_utility/sync_dialog/sync_dialog_view.dart';
import 'package:ideas_desktop/view/menu/menu_table.dart';
import 'package:ideas_desktop/view/select-printer-mapping/select_printer_mapping_view.dart';

class MenuController extends BaseController {
  MenuService menuService = Get.find();
  ServerService serverService = Get.find();
  TextEditingController searchCtrl = TextEditingController();

  RxBool hideSearch = RxBool(true);
  RxList<MenuItemLocalEditModel> menu = RxList([]);
  RxList<MenuItemLocalEditModel> filteredMenu = RxList([]);
  RxList<MenuItemLocalPrinterMappingModel> printers = RxList([]);
  Rx<MenuDataSource?> menuDataSource = Rx<MenuDataSource?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrinters();
      await getCategories();
    });
  }

  Future getPrinters() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    printers(await menuService.getLocalPrinters(authStore.user!.branchId));
    EasyLoading.dismiss();
  }

  Future getCategories() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    menu(await menuService.getMenuForLocalEdit(authStore.user!.branchId));
    filteredMenu(menu);
    menuDataSource(MenuDataSource(
      menuItems: filteredMenu,
    ));
    EasyLoading.dismiss();
  }

  changeIsVisible(int menuItemId, bool isVisible) {
    var tempSort = menuDataSource.value!.sortedColumns;
    var item = menu.where((element) => element.menuItemId == menuItemId).first;
    item.isVisible = isVisible;
    menuDataSource(MenuDataSource(
      menuItems: filteredMenu,
    ));
    menuDataSource.value!.sortedColumns.addAll(tempSort);
    menuDataSource.value!.sort();
  }

  changeTopList(int menuItemId, bool topList) {
    var tempSort = menuDataSource.value!.sortedColumns;
    var item = menu.where((element) => element.menuItemId == menuItemId).first;
    item.topList = topList;
    menuDataSource(MenuDataSource(
      menuItems: filteredMenu,
    ));
    menuDataSource.value!.sortedColumns.addAll(tempSort);
    menuDataSource.value!.sort();
  }

  void filterMenuItems() {
    filteredMenu(menu
        .where((element) => element.nameTr!
            .toUpperCase()
            .contains(searchCtrl.text.toUpperCase()))
        .toList());
    menuDataSource(MenuDataSource(
      menuItems: filteredMenu,
    ));
  }

  Future updateLocalMenu() async {
    try {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await menuService.updateLocalMenu(menu);
      if (res != null) {
        getCategories();
        menuDataSource.value!.sort();

        // update dialog
        Get.dialog(const SyncDialog());
      }
      EasyLoading.dismiss();
    } on Exception {
      EasyLoading.dismiss();
    }
  }

  openSelectPrinter(
      int menuItemId, List<MenuItemLocalPrinterMappingModel> m) async {
    var res = await Get.dialog(
      const SelectPrinterMapping(),
      arguments: m,
    );
    if (res != null) {
      var tempSort = menuDataSource.value!.sortedColumns;
      var item =
          menu.where((element) => element.menuItemId == menuItemId).first;
      item.printerMappings = [];
      for (MenuItemLocalPrinterMappingModel printer in res) {
        item.printerMappings!.add(printer);
      }
      menuDataSource(MenuDataSource(
        menuItems: filteredMenu,
      ));
      menuDataSource.value!.sortedColumns.addAll(tempSort);
      menuDataSource.value!.sort();
    }
  }

  void navigateToCreateMenuItemPage(int? id) async {
    Get.toNamed('/create-menu-item', arguments: id)!.then((value) async {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await serverService.syncChanges(authStore.user!.branchId!);
      await getCategories();
      EasyLoading.dismiss();
    });
  }

  deleteMenuItem(MenuItemLocalEditModel item) async {
    var confirm = await openYesNoDialog(
        "${item.nameTr!} ürünün silmek istediğinize emin misiniz?");

    if (confirm) {
      var res = await menuService.deleteMenuItem(
          authStore.user!.serverBranchId, item.serverMenuItemId!);
      if (res != null) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await serverService.syncChanges(authStore.user!.branchId!);
        await getCategories();
        EasyLoading.dismiss();
      }
    }
  }
}
