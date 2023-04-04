import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/menu/condiments/condiments_table.dart';
import 'package:ideas_desktop/view/menu/create-condiment/create_condiment_view.dart';

class CondimentsController extends BaseController {
  late MenuService menuService = Get.find();
  late ServerService serverService = Get.find();

  final TextEditingController searchCtrl = TextEditingController();

  RxList<CondimentForEditOutput> condiments =
      RxList<CondimentForEditOutput>([]);
  RxList<CondimentForEditOutput> filteredCondiments = RxList([]);
  Rx<CondimentsTableDataSource?> condimentsDataSource =
      Rx<CondimentsTableDataSource?>(null);

  RxBool showLoading = RxBool(false);
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondiments();
    });
  }

  Future getCondiments() async {
    condiments(await menuService
        .getCondimentsForEdit(authStore.user!.serverBranchId!));
    filteredCondiments(condiments);
    condimentsDataSource(CondimentsTableDataSource(
      condiments: filteredCondiments,
    ));
  }

  void filterCondiments() {
    filteredCondiments(condiments
        .where((element) => element.nameTr!
            .toLowerCase()
            .contains(searchCtrl.text.toLowerCase()))
        .toList());

    condimentsDataSource(CondimentsTableDataSource(
      condiments: filteredCondiments,
    ));
  }

  changeLoading(bool val) {
    showLoading(val);
  }

  openNewCondimentDialog() async {
    await Get.dialog(
      const CreateCondimentPage(),
    ).then((value) async {
      if (value != null) {
        changeLoading(true);
        await serverService.syncChanges(authStore.user!.branchId!);
        await getCondiments();
        changeLoading(false);
      }
    });
  }
}
