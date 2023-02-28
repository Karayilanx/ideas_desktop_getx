import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/model/printer_model.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';
import 'package:ideas_desktop_getx/service/printer/printer_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';
import 'package:ideas_desktop_getx/view/menu/create-category/create_category_view.dart';
import 'package:ideas_desktop_getx/view/menu/select-condiment-group/select_condiment_group_view.dart';

class CreateMenuItemController extends BaseController {
  final int? menuItemId = Get.arguments;
  late MenuService menuService = Get.find();
  late PrinterService printerService = Get.find();
  late ServerService serverService = Get.find();

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  final TextEditingController barcodeCtrl = TextEditingController();
  final TextEditingController kdvCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();

  Rx<CreateMenuItemModel> menuItemModel =
      Rx<CreateMenuItemModel>(CreateMenuItemModel(
          printerIds: [],
          branchGroupIds: [],
          menuItemId: -1,
          hasPortion: false,
          defaultSellUnitId: 1,
          barcode: "",
          condimentGroupIds: [],
          descriptionEn: "",
          descriptionTr: "",
          hasStock: false,
          isChainMenuItem: false,
          kdv: 0,
          nameEn: "",
          qrNameEn: "",
          nameTr: "",
          price: 0,
          qrNameTr: "",
          portions: [
            PortionListItemInput(
              condimentId: null,
              isActive: true,
              isPriceToShow: true,
              portionName: "TEK",
              price: 0,
            ),
            PortionListItemInput(
              condimentId: null,
              isActive: true,
              isPriceToShow: false,
              portionName: "BUÇUK",
              price: 0,
            ),
            PortionListItemInput(
              condimentId: null,
              isActive: true,
              isPriceToShow: false,
              portionName: "DUBLE",
              price: 0,
            )
          ]));

  RxInt selectedTabIndex = RxInt(0);
  RxBool showLoading = RxBool(false);
  RxList<MenuItemCategory> categories = RxList([]);
  RxList<CondimentGroupForEditOutput> condimentGroups = RxList([]);
  RxList<PrinterOutput> printers = RxList([]);

  @override
  void onInit() {
    super.onInit();
    menuItemModel.value.branchId = authStore.user!.serverBranchId!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondimentGroups();
      await getCategoriesForEdit();
      await getPrinters();
      if (menuItemId != null) {
        await getMenuItemForEdit();
      }
    });
  }

  Future getMenuItemForEdit() async {
    var res = await menuService.getMenuItemForEdit(
        authStore.user!.serverBranchId!, menuItemId!);
    if (res != null) {
      menuItemModel(res);
      nameCtrl.text = menuItemModel.value.nameTr!;
      priceCtrl.text = menuItemModel.value.price.toString();
      kdvCtrl.text = menuItemModel.value.kdv.toString();
      barcodeCtrl.text = menuItemModel.value.barcode.toString();
    } else {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }
  }

  Future getCondimentGroups() async {
    condimentGroups(await menuService
        .getCondimentGroupsForEdit(authStore.user!.serverBranchId!));
  }

  Future getCategoriesForEdit() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    categories(await menuService
        .getCategoriesForEdit(authStore.user!.serverBranchId!));

    EasyLoading.dismiss();
  }

  Future getPrinters() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    printers(await printerService
        .getPrintersForEdit(authStore.user!.serverBranchId));

    EasyLoading.dismiss();
  }

  changeSelectedTabIndex(int index) {
    selectedTabIndex(index);
  }

  getSelectedPrinterNames() {
    var printerNames = [];

    for (var selectedPrinterId in menuItemModel.value.printerIds!) {
      for (var printer in printers) {
        if (selectedPrinterId == printer.printerId) {
          printerNames.add(printer.printerName);
        }
      }
    }

    return printerNames.join(" - ");
  }

  isPrinterSelected(int id) {
    return menuItemModel.value.printerIds!.contains(id);
  }

  addPrinter(int id) {
    menuItemModel.update((val) {
      val!.printerIds!.add(id);
    });
  }

  removePrinter(int id) {
    menuItemModel.update((val) {
      val!.printerIds!.remove(id);
    });
    menuItemModel = menuItemModel;
  }

  changeSelectedCategory(int subCatId) {
    menuItemModel.update((val) {
      val!.subCategoryId = subCatId;
    });
  }

  changeHasPortion(bool hasPortion) {
    menuItemModel.update((val) {
      val!.hasPortion = hasPortion;
    });
  }

  addPortion() {
    menuItemModel.update((val) {
      val!.portions!.add(PortionListItemInput(
        condimentId: null,
        isActive: true,
        isPriceToShow: false,
        portionName: "",
        price: 0,
      ));
    });
  }

  removePortion(int index) {
    if (menuItemModel.value.portions!.length > 2) {
      menuItemModel.value.portions!.removeAt(index);
    }
    if (!menuItemModel.value.portions!
        .any((element) => element.isPriceToShow!)) {
      menuItemModel.value.portions![0].isPriceToShow = true;
    }
    menuItemModel.refresh();
  }

  changeIsPriceToShow(int index) {
    for (var i = 0; i < menuItemModel.value.portions!.length; i++) {
      var por = menuItemModel.value.portions![i];
      if (i != index) {
        por.isPriceToShow = false;
      } else {
        por.isPriceToShow = true;
      }
    }
    menuItemModel.refresh();
  }

  createMenuItem() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    menuItemModel.value.nameTr = nameCtrl.text;
    menuItemModel.value.barcode = barcodeCtrl.text;
    var kdv = double.tryParse(kdvCtrl.text);
    if (kdv != null) menuItemModel.value.kdv = kdv;
    var price = double.tryParse(priceCtrl.text);
    if (price != null) menuItemModel.value.price = price;
    var res = await menuService.createMenuItem(menuItemModel.value);
    if (res != null) {
      if (menuItemId == null) {
        Get.snackbar(
          "Başarılı",
          "Ürün başarıyla eklendi.",
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          colorText: Colors.white,
        );
      } else {
        Get.back();
      }
    }
    EasyLoading.dismiss();
  }

  openAddCategoryDialog() async {
    await Get.dialog(
      CreateCategoryPage(),
    ).then((value) async {
      showLoading(true);
      await serverService.syncChanges(authStore.user!.branchId!);
      await getCategoriesForEdit();
      showLoading(false);
    });
  }

  openSelectCondimentPage() async {
    await Get.dialog(SelectCondimentGroupPage(),
            arguments: menuItemModel.value.condimentGroupIds!)
        .then((value) async {
      if (value != null) {
        await getCondimentGroups();
        menuItemModel.update((val) {
          val!.condimentGroupIds = value;
        });
      }
    });
  }

  removeCondimentGroupSelection(int condimentGroupId) {
    menuItemModel.update((val) {
      val!.condimentGroupIds!.remove(condimentGroupId);
    });
  }

  closePage() {
    Get.back();
  }
}
