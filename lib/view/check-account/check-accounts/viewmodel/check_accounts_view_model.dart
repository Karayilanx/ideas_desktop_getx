import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import '../../../../model/check_account_model.dart';
import '../../../../model/check_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../../check-account-detail/view/check_account_detail_view.dart';
import '../component/select_check_account_view.dart';
import '../navigation/check_accounts_navigation_args.dart';

class CheckAccountsController extends BaseController {
  final int? checkId = (Get.arguments as CheckAccountsArguments).checkId;
  final bool? transferAll =
      (Get.arguments as CheckAccountsArguments).transferAll;
  final List<CheckMenuItemModel?>? menuItems =
      (Get.arguments as CheckAccountsArguments).menuItems;
  final CheckAccountsPageType type =
      (Get.arguments as CheckAccountsArguments).type;

  CheckAccountService checkAccountService = Get.find();
  CheckService checkService = Get.find();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  late final List<CheckAccountType> types = [
    CheckAccountType(name: 'Hepsi', value: 0),
    CheckAccountType(name: 'Müşteri', value: 1),
    CheckAccountType(name: 'Tedarikçi', value: 2),
    // CheckAccountType(name: 'Banka/POS', value: 5),
    // CheckAccountType(name: 'Kasa', value: 6),
    CheckAccountType(name: 'Ödenmez', value: 8),
  ];

  RxInt selectedType = RxInt(1);
  RxList<CheckAccountListItem> checkAccounts = RxList([]);
  RxList<CheckAccountListItem> filteredCheckAccounts = RxList([]);
  Rx<CheckAccountListItem?> selectedCheckAccount =
      Rx<CheckAccountListItem?>(null);
  Rx<CheckAccountSummaryModel?> checkAccountSummary =
      Rx<CheckAccountSummaryModel?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckAccounts();
    });
  }

  Future getCheckAccounts() async {
    EasyLoading.show(
      status: 'Lütfen bekleyin...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    List<int> checkAccountTypeIds = [];
    checkAccounts(await checkAccountService.getCheckAccounts(
      GetCheckAccountsInput(
          branchId: authStore.user!.branchId,
          checkAccountTypeIds: checkAccountTypeIds),
    ));
    if (checkId != null && checkId! > 0) {
      if (type == CheckAccountsPageType.Check) {
        checkAccounts(
            checkAccounts.where((x) => x.checkAccountTypeId == 1).toList());
        filteredCheckAccounts(
            checkAccounts.where((x) => x.checkAccountTypeId == 1).toList());
        changeSelectedType(1);
      } else if (type == CheckAccountsPageType.Unpayable) {
        checkAccounts(checkAccounts
            .where((x) =>
                x.checkAccountTypeId == 8 ||
                x.checkAccountTypeId == 9 ||
                x.checkAccountTypeId == 10)
            .toList());
        filteredCheckAccounts(checkAccounts);
        changeSelectedType(0);
      } else if (type == CheckAccountsPageType.CheckCustomer) {
        checkAccounts.refresh();
        filteredCheckAccounts(checkAccounts);
        changeSelectedType(1);
      }
    } else {
      checkAccounts.refresh();
      filteredCheckAccounts(checkAccounts);
      changeSelectedType(1);
    }

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

  Future showCheckAccountDetailsDialog(int checkAccountId) async {
    int? res = await Get.dialog(
      const CheckAccountDetailPage(),
      barrierDismissible: false,
      arguments: [
        type,
        checkAccountId,
      ],
    );
    if (res != null) {
      await getCheckAccounts();
      filterCheckAccounts(searchCtrl.text);
      for (var item in checkAccounts) {
        if (item.checkAccountId == res) selectCheckAccount(item);
      }
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
    if (type == CheckAccountsPageType.Check ||
        type == CheckAccountsPageType.CheckCustomer ||
        type == CheckAccountsPageType.Unpayable) {
      selectedCheckAccount(item);
    } else if (type == CheckAccountsPageType.CheckAccount) {
      selectedCheckAccount(item);
      getCheckAccountSummary();
    }
  }

  getCheckAccountSummary() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkAccountSummary(await checkAccountService
        .getCheckAccountSummary(selectedCheckAccount.value!.checkAccountId));
    EasyLoading.dismiss();
  }

  void navigateToCheckAccountTransactions(int? checkAccountId) async {
    await Get.toNamed('check-acoount-transactions', arguments: checkAccountId);
    await getCheckAccounts();
    if (selectedCheckAccount.value != null) getCheckAccountSummary();
  }

  Future insertCheckAccountTransaction(
      int checkAccountTransactionTypeId) async {
    if (selectedCheckAccount.value != null) {
      if (priceCtrl.text == '') {
        showDefaultDialog(
            'Hata', 'Önce ödeme yapmak istediğiniz tutarı giriniz!');
        return;
      }
      EasyLoading.show(
        status: 'Ödeme işleniyor...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var tr = await checkAccountService
          .insertCheckAccountTransaction(CheckAccountTransactionModel(
        amount: priceCtrl.text.getDouble,
        checkAccountId: selectedCheckAccount.value!.checkAccountId,
        checkAccountTransactionTypeId: checkAccountTransactionTypeId,
        terminalUserId: authStore.user!.terminalUserId!,
      ));
      EasyLoading.dismiss();
      if (tr!.value! > 0) {
        await getCheckAccountSummary();
        updateCheckAccountBalance(selectedCheckAccount.value!.checkAccountId,
            checkAccountSummary.value!.balance);
        priceCtrl.text = '';
      }
    }
  }

  void updateCheckAccountBalance(int? checkAccountId, double? newBalance) {
    for (var acc in checkAccounts) {
      if (acc.checkAccountId == checkAccountId) {
        acc.balance = newBalance;
        break;
      }
    }

    checkAccounts.refresh();
  }

  void getPercentage() {
    priceCtrl.text = (selectedCheckAccount.value!.balance!.abs() *
            (double.parse(priceCtrl.text).abs()) /
            100)
        .abs()
        .toStringAsFixed(2);
  }

  Future changeCheckCustomer() async {
    if (selectedCheckAccount.value != null) {
      if (checkId! > 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkService.changeCheckCustomer(
            checkId,
            selectedCheckAccount.value!.checkAccountId,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
        if (res != null) {
          if (authStore.settings!.autoLock!) {
            Get.offAllNamed('/');
          } else {
            Get.offAllNamed('/home');
          }
        }
      } else {
        Get.back(result: selectedCheckAccount.value!.checkAccountId);
      }
    }
  }

  Future transferCheckToCheckAccount() async {
    if (selectedCheckAccount.value != null) {
      TransferCheckToCheckAccountInput inp = TransferCheckToCheckAccountInput(
        checkAccountId: selectedCheckAccount.value!.checkAccountId,
        checkId: checkId,
        menuItems: menuItems,
        transferAll: transferAll,
        branchId: authStore.user!.branchId!,
        terminalUserId: authStore.user!.terminalUserId!,
      );
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await checkAccountService.transferCheckToCheckAccount(inp);
      EasyLoading.dismiss();
      if (res != null) {
        if (authStore.settings!.autoLock!) {
          Get.offAllNamed('/');
        } else {
          Get.offAllNamed('/home');
        }
      }
    }
  }

  Future closeUnpayableCheck() async {
    if (selectedCheckAccount.value != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await checkService.closeUnpayableCheck(
        checkId,
        selectedCheckAccount.value!.checkAccountId,
        authStore.user!.branchId!,
        authStore.user!.terminalUserId!,
      );
      EasyLoading.dismiss();
      if (res != null) {
        if (authStore.settings!.autoLock!) {
          Get.offAllNamed('/');
        } else {
          Get.offAllNamed('/home');
        }
      }
    }
  }

  Future removeCheckAccount() async {
    var res = await openYesNoDialog(
        '${selectedCheckAccount.value!.name} adlı cari hesap kaldırılacak. Onaylıyor musunuz?');
    if (res) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var ress = await checkAccountService
          .removeCheckAccount(selectedCheckAccount.value!.checkAccountId!);
      EasyLoading.dismiss();
      if (ress != null) {
        getCheckAccounts();
        selectedCheckAccount(null);
      }
    }
  }

  Future markCheckAccountUnpayable() async {
    var res = await openYesNoDialog(
        '${selectedCheckAccount.value!.name} adlı cari hesap ödenmeze atılacak. Onaylıyor musunuz?');
    if (res) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var ress = await checkAccountService.markCheckAccountUnpayable(
          selectedCheckAccount.value!.checkAccountId!);
      EasyLoading.dismiss();
      if (ress != null) getCheckAccounts();
    }
  }

  Future transferCheckAccountToCheckAccount() async {
    var res = await Get.dialog(const SelectCheckAccountPage(),
        arguments: [selectedCheckAccount.value!.checkAccountId!, true, null]);
    if (res != null) {
      await getCheckAccounts();
      selectedCheckAccount(null);
    }
  }

  void closePage() {
    Get.back();
  }
}

class CheckAccountType {
  int value;
  String name;

  CheckAccountType({required this.name, required this.value});
}
