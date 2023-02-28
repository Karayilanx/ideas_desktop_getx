import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';
import 'package:ideas_desktop_getx/view/menu/condiment-groups/condiment_groups_table.dart';
import 'package:ideas_desktop_getx/view/menu/create-condiment-group/create_condiment_group_view.dart';

class CondimentGroupsController extends BaseController {
  MenuService menuService = Get.find();
  ServerService serverService = Get.find();

  final TextEditingController searchCtrl = TextEditingController();

  RxList<CondimentGroupForEditOutput> condimentGroups = RxList([]);
  RxList<CondimentGroupForEditOutput> filteredCondimentGroups = RxList([]);
  Rx<CondimentGroupsTableDataSource?> condimentGroupDataSource = Rx(null);

  RxBool showLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondimentGroups();
    });
  }

  Future getCondimentGroups() async {
    condimentGroups(await menuService
        .getCondimentGroupsForEdit(authStore.user!.serverBranchId!));

    filteredCondimentGroups = condimentGroups;
    condimentGroupDataSource(CondimentGroupsTableDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  void filterCondimentGroups() {
    filteredCondimentGroups(condimentGroups
        .where((element) => element.nameTr!
            .toLowerCase()
            .contains(searchCtrl.text.toLowerCase()))
        .toList());
    condimentGroupDataSource(CondimentGroupsTableDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  changeLoading(bool val) {
    showLoading(val);
  }

  openNewCondimentGroupDialog() async {
    await Get.dialog(
      CreateCondimentGroupPage(),
    ).then((value) async {
      if (value != null) {
        changeLoading(true);
        await serverService.syncChanges(authStore.user!.branchId!);
        await getCondimentGroups();
        changeLoading(false);
      }
    });
  }
}
