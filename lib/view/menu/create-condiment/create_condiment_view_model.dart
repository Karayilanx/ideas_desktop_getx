import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/service/menu/menu_service.dart';

class CreateCondimentController extends BaseController {
  MenuService menuService = Get.find();
  final TextEditingController nameTrController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController(text: "0");
  final TextEditingController searchCondimentGroupCtrl =
      TextEditingController();

  RxList<CondimentGroupForEditOutput> condimentGroups = RxList([]);
  RxList<CondimentGroupForEditOutput> selectedCondimentGroups = RxList([]);

  RxBool isLoading = RxBool(false);

  Rx<CreateCondimentInput> input = Rx<CreateCondimentInput>(
      CreateCondimentInput(condimentGroupIds: [], condimentId: -1));
  @override
  void onInit() {
    super.onInit();
    input.value.branchId = authStore.user!.serverBranchId!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCondimentGroups();
    });
  }

  Future getCondimentGroups() async {
    condimentGroups(await menuService
        .getCondimentGroupsForEdit(authStore.user!.serverBranchId!));
  }

  isCondimentGroupSelected(CondimentGroupForEditOutput id) {
    return selectedCondimentGroups.contains(id);
  }

  addCondimentGroup(CondimentGroupForEditOutput id) {
    selectedCondimentGroups.add(id);
    selectedCondimentGroups.refresh();
  }

  removeCondimentGroup(CondimentGroupForEditOutput id) {
    selectedCondimentGroups.remove(id);
    selectedCondimentGroups.refresh();
  }

  getSelectedCondimentGrouppNames() {
    return selectedCondimentGroups.length.toString();
  }

  changeLoading(bool val) {
    isLoading(val);
  }

  createCondiment() async {
    try {
      changeLoading(true);
      input.value.condimentGroupIds = [];
      input.value.nameTr = nameTrController.text;
      input.value.nameEn = nameEnController.text;
      var price = double.tryParse(priceCtrl.text);
      if (price != null) input.value.price = price;
      for (var item in selectedCondimentGroups) {
        input.value.condimentGroupIds!.add(item.condimentGroupId!);
      }

      var res = await menuService.createCondiment(input.value);
      changeLoading(false);
      if (res != null) {
        Get.back(result: res);
      }
    } on Exception {
      changeLoading(false);
    }
  }
}
