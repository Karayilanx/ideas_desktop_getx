import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../../../model/check_account_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../viewmodel/check_accounts_view_model.dart';

class SelectCheckAccountController extends BaseController {
  final bool transferAll = Get.arguments[1];
  int? endOfDayId = Get.arguments[2];
  int checkAccountId = Get.arguments[0];

  CheckAccountService checkAccountService = Get.find();
  CheckService checkService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxInt selectedType = RxInt(1);
  RxList<CheckAccountListItem> checkAccounts = RxList([]);
  RxList<CheckAccountListItem> filteredCheckAccounts = RxList([]);
  Rx<CheckAccountListItem?> selectedCheckAccount =
      Rx<CheckAccountListItem?>(null);

  final List<CheckAccountType> types = [
    CheckAccountType(name: 'Hepsi', value: 0),
    CheckAccountType(name: 'Müşteri', value: 1),
    CheckAccountType(name: 'Tedarikçi', value: 2),
    CheckAccountType(name: 'Banka/POS', value: 5),
    CheckAccountType(name: 'Kasa', value: 6),
    CheckAccountType(name: 'Ödenmez', value: 8),
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckAccounts();
    });
  }

  Future getCheckAccounts() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    List<int> checkAccountTypeIds = [];
    checkAccounts(await checkAccountService.getCheckAccounts(
      GetCheckAccountsInput(
          branchId: authStore.user!.branchId,
          checkAccountTypeIds: checkAccountTypeIds),
    ));
    filteredCheckAccounts(checkAccounts);
    EasyLoading.dismiss();
  }

  changeSelectedType(int val) {
    selectedType(val);
    filterCheckAccounts(searchCtrl.text);
  }

  void filterCheckAccounts(String text) {
    if (selectedType.value != 0) {
      filteredCheckAccounts(checkAccounts
          .where((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()) &&
              element.checkAccountTypeId == selectedType.value)
          .toList());
    } else {
      filteredCheckAccounts(checkAccounts
          .where((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()))
          .toList());
    }
  }

  bool isAccountSelected(CheckAccountListItem item) {
    if (selectedCheckAccount.value != null &&
        selectedCheckAccount.value!.checkAccountId == item.checkAccountId) {
      return true;
    }
    return false;
  }

  void selectCheckAccount(CheckAccountListItem item) {
    selectedCheckAccount(item);
  }

  void save() async {
    if (selectedCheckAccount.value != null) {
      if (transferAll) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkAccountService.transferCheckAccount(
            checkAccountId, selectedCheckAccount.value!.checkAccountId!);
        EasyLoading.dismiss();
        if (res != null) Get.back(result: true);
      } else {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkAccountService.transferCheckAccountTransaction(
            checkAccountId,
            selectedCheckAccount.value!.checkAccountId!,
            endOfDayId);
        EasyLoading.dismiss();
        if (res != null) Get.back(result: true);
      }
    }
  }

  void closePage() {
    Get.back();
  }
}
