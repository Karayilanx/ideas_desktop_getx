import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/check_account_model.dart';
import 'package:ideas_desktop/model/eft_pos_model.dart';
import 'package:ideas_desktop/service/check_account/check_account_service.dart';
import 'package:ideas_desktop/service/eft_pos/eft_pos_service.dart';
import 'package:ideas_desktop/view/pos-integration/poss_table.dart';

class PosIntegrationController extends BaseController {
  EftPosService posService = Get.find();
  CheckAccountService checkAccountService = Get.find();

  RxList<CheckAccountListItem> checkAccounts = RxList([]);
  RxList<EftPosModel> poss = RxList([]);
  Rx<PossDataSource?> possDataSource = Rx<PossDataSource?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPoss();
      await getCheckAccounts();
    });
  }

  Future getCheckAccounts() async {
    EasyLoading.show(
      status: 'Lütfen bekleyin...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    List<int> checkAccountTypeIds = [5, 6];
    checkAccounts(await checkAccountService.getCheckAccounts(
      GetCheckAccountsInput(
          branchId: authStore.user!.branchId,
          checkAccountTypeIds: checkAccountTypeIds),
    ));

    EasyLoading.dismiss();
  }

  Future getPoss() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    poss(await posService.getEftPoss(authStore.user!.branchId!));

    possDataSource(PossDataSource(
      menuItems: poss,
    ));
    EasyLoading.dismiss();
  }

  saveChanges() async {
    try {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await posService.saveEftPoss(poss);
      if (result != null && result.value == 1) {
        await getPoss();
      } else {
        showSnackbarError('Bir hata oluştu! Lütfen tekrar deneyiniz!');
      }
      EasyLoading.dismiss();
    } on Exception {
      EasyLoading.dismiss();
    }
  }

  removeEftPos(int id) async {
    try {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await posService.removeEftPos(id);
      if (result != null && result.value == 1) {
        await getPoss();
      } else {
        showSnackbarError('Bir hata oluştu! Lütfen tekrar deneyiniz!');
      }
      EasyLoading.dismiss();
    } on Exception {
      EasyLoading.dismiss();
    }
  }

  addNewRow() {
    poss.add(EftPosModel(
      branchId: authStore.user!.branchId!,
      eftPosId: poss.isEmpty
          ? -1
          : poss.last.eftPosId! < 0
              ? poss.last.eftPosId! - 1
              : -1,
      isActive: true,
      checkAccountIds: [],
      checkAccountName: "",
      eftPosName: "",
      fiscalId: "",
      ipAddress: "",
    ));

    possDataSource(PossDataSource(
      menuItems: poss,
    ));
  }

  changeName(int? eftPosId, String name) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.eftPosName = name;
      }
    }
  }

  changeIp(int? eftPosId, String name) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.ipAddress = name;
      }
    }
  }

  changeFiscal(int? eftPosId, String name) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.fiscalId = name;
      }
    }
  }

  changeacquirer(int? eftPosId, String name) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.acquirerId = name;
      }
    }
  }

  isCheckAccountSelected(int id, int? eftPosId) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        return item.checkAccountIds!.any((element) => element == id);
      }
    }
  }

  addCondiment(dynamic id, int? eftPosId) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.checkAccountIds!.add(id);
        checkAccounts.refresh();
      }
    }
  }

  removeCondiment(dynamic id, int? eftPosId) {
    for (var i = 0; i < poss.length; i++) {
      var item = poss[i];
      if (item.eftPosId == eftPosId) {
        item.checkAccountIds!.remove(id);
        checkAccounts.refresh();
      }
    }
  }

  voidReceipt(int eftPosId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await posService.connectEftPos(authStore.user!.branchId!, eftPosId);
    var res = await posService.voidReceipt(eftPosId);
    if (res != null && res.value == 1) {
      await getPoss();
    } else {
      showSnackbarError('Bir hata oluştu! Lütfen tekrar deneyiniz!');
    }
    EasyLoading.dismiss();
  }

  closeReceipt(int eftPosId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await posService.connectEftPos(authStore.user!.branchId!, eftPosId);
    await posService.closeReceipt(eftPosId, null, 0, 0);
    EasyLoading.dismiss();
  }
}
