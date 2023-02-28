import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';
import '../authentication/auth_store.dart';

class SelectPrinterMappingController extends BaseController {
  final List<MenuItemLocalPrinterMappingModel> initialValue = Get.arguments;

  late MenuService menuService = Get.find();
  RxList<MenuItemLocalPrinterMappingModel> printers = RxList([]);
  RxList<MenuItemLocalPrinterMappingModel> selectedPrinters = RxList([]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrinters();
      for (var item in initialValue) {
        selectPrinter(item);
      }
    });
  }

  Future getPrinters() async {
    var res = await menuService.getLocalPrinters(authStore.user!.branchId);
    if (res != null) {
      printers(res);
    }
  }

  bool isPrinterSelected(MenuItemLocalPrinterMappingModel pr) {
    return selectedPrinters
        .where((element) => element.printerId == pr.printerId)
        .isNotEmpty;
  }

  void selectPrinter(MenuItemLocalPrinterMappingModel pr) {
    if (!isPrinterSelected(pr)) {
      selectedPrinters.add(pr);
    } else {
      selectedPrinters.remove(pr);
    }
    selectedPrinters.refresh();
  }
}
