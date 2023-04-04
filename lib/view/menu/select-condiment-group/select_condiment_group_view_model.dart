import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/menu/create-condiment-group/create_condiment_group_view.dart';
import 'package:ideas_desktop/view/menu/select-condiment-group/select_condiment_table.dart';

class SelectCondimentGroupController extends BaseController {
  final List<int> selectedIds = Get.arguments;

  late MenuService menuService = Get.find();
  late ServerService serverService = Get.find();
  TextEditingController searchCtrl = TextEditingController();

  Rx<SelectCondimentDataSource?> selectCondimentDataSource = Rx(null);
  RxList<int> selectedCondimentGroupIds = RxList([]);
  RxList<CondimentGroupForEditOutput> condimentGroups = RxList([]);
  RxList<CondimentGroupForEditOutput> filteredCondimentGroups = RxList([]);

  RxBool showLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondimentGroups();
      initSelections();
    });
  }

  Future getCondimentGroups() async {
    condimentGroups(await menuService
        .getCondimentGroupsForEdit(authStore.user!.serverBranchId!));

    filteredCondimentGroups = condimentGroups;
    selectCondimentDataSource(SelectCondimentDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  initSelections() {
    for (var element in selectedIds) {
      selectCondimentGroup(element);
    }
  }

  selectCondimentGroup(int condimentGroupId) {
    selectedCondimentGroupIds.add(condimentGroupId);
    selectCondimentDataSource(SelectCondimentDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  removeCondimentGroupSelection(int condimentGroupId) {
    selectedCondimentGroupIds.remove(condimentGroupId);
    selectCondimentDataSource(SelectCondimentDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  void filterCondimentGroups() {
    filteredCondimentGroups(condimentGroups
        .where((element) => element.nameTr!
            .toLowerCase()
            .contains(searchCtrl.text.toLowerCase()))
        .toList());
    selectCondimentDataSource(SelectCondimentDataSource(
      condimentGroups: filteredCondimentGroups,
    ));
  }

  isCondimentGroupSelected(int condimentGroupId) {
    return selectedCondimentGroupIds.contains(condimentGroupId);
  }

  closePage() {
    Get.back();
  }

  saveSelection() {
    Get.back(result: selectedCondimentGroupIds);
  }

  changeLoading(bool val) {
    showLoading(val);
  }

  openNewCondimentGroupDialog() async {
    await Get.dialog(
      const CreateCondimentGroupPage(),
    ).then((value) async {
      if (value != null) {
        changeLoading(true);
        await serverService.syncChanges(authStore.user!.branchId!);
        await getCondimentGroups();
        selectCondimentGroup(value.condimentGroupId);
        changeLoading(false);
      }
    });
  }
}
