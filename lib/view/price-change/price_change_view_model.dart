import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/price-change/price_change_table.dart';

class PriceChangeController extends BaseController {
  MenuService menuService = Get.find();
  ServerService serverService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxBool hideSearch = RxBool(true);
  Rx<PriceChangeModel?> filteredPriceChangeModel = Rx<PriceChangeModel?>(null);
  RxList<MenuItemLocalPrinterMappingModel> printers =
      RxList<MenuItemLocalPrinterMappingModel>([]);
  Rx<PriceChangeDataSource?> menuDataSource = Rx<PriceChangeDataSource?>(null);
  Rx<PriceChangeModel?> priceChangeModel = Rx<PriceChangeModel?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getItemsForPriceChange();
    });
  }

  Future getItemsForPriceChange() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    priceChangeModel(await menuService
        .getItemsForPriceChange(authStore.user!.serverBranchId));
    if (priceChangeModel.value == null) {
    } else {
      filteredPriceChangeModel = priceChangeModel;

      filteredPriceChangeModel(PriceChangeModel(
        branchId: priceChangeModel.value!.branchId,
        categories: [...priceChangeModel.value!.categories!],
        items: [...priceChangeModel.value!.items!],
        subCategories: [...priceChangeModel.value!.categories!],
      ));

      menuDataSource(PriceChangeDataSource(
        menuItems: filteredPriceChangeModel.value!.items!,
      ));
    }
    EasyLoading.dismiss();
  }

  void filterMenuItems() {
    filteredPriceChangeModel.value!.items = priceChangeModel.value!.items!
        .where((element) =>
            element.name!.toUpperCase().contains(searchCtrl.text.toUpperCase()))
        .toList();

    menuDataSource(PriceChangeDataSource(
      menuItems: filteredPriceChangeModel.value!.items!,
    ));
  }

  changePrice(int? menuItemId, int? condimentId, String price) {
    for (var i = 0; i < priceChangeModel.value!.items!.length; i++) {
      var item = priceChangeModel.value!.items![i];
      if (item.menuItemId == menuItemId && item.condimentId == condimentId) {
        var newPrice = double.tryParse(price);
        if (newPrice != null) item.price = newPrice;
      }
    }
  }

  Future savePriceChange() async {
    try {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await menuService.savePriceChange(priceChangeModel.value!);
      if (result != null && result.value == 1) {
        await getItemsForPriceChange();
        menuDataSource.value!.sort();

        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await serverService.syncChanges(authStore.user!.branchId!);
        EasyLoading.dismiss();

        if (res != null) {
          showSnackbarError('Fiyat değişimi başarıyla kaydedildi!');
        } else {
          showSnackbarError(
              'Fiyat değişimi sırasında bir hata oluştu! Lütfen tekrar deneyiniz!');
        }
      } else {
        showSnackbarError(
            'Fiyat değişimi sırasında bir hata oluştu! Lütfen tekrar deneyiniz!');
      }
      EasyLoading.dismiss();
    } on Exception {
      EasyLoading.dismiss();
    }
  }
}
