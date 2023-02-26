import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../model/check_account_model.dart';
import '../../../../model/check_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../../../_utility/service_helper.dart';
import '../../../authentication/auth_store.dart';
import '../../check-account-detail/view/check_account_detail_view.dart';
import '../../check-account-transactions/navigation/check_account_transactions_navigation_args.dart';
import '../component/select_check_account_view.dart';
import '../navigation/check_accounts_navigation_args.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../../../../core/extension/string_extension.dart';

part 'check_accounts_view_model.g.dart';

class CheckAccountsViewModel = _CheckAccountsViewModelBase
    with _$CheckAccountsViewModel;

abstract class _CheckAccountsViewModelBase
    with Store, BaseViewModel, ServiceHelper {
  final int? checkId;
  final bool? transferAll;
  final List<CheckMenuItemModel?>? menuItems;
  final CheckAccountsPageType type;
  late CheckAccountService checkAccountService;
  late CheckService checkService;
  late AuthStore authStore;
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  final List<CheckAccountType> types = [
    CheckAccountType(name: 'Hepsi', value: 0),
    CheckAccountType(name: 'Müşteri', value: 1),
    CheckAccountType(name: 'Tedarikçi', value: 2),
    // CheckAccountType(name: 'Banka/POS', value: 5),
    // CheckAccountType(name: 'Kasa', value: 6),
    CheckAccountType(name: 'Ödenmez', value: 8),
  ];

  @observable
  int selectedType = 1;
  @observable
  List<CheckAccountListItem>? checkAccounts = [];
  @observable
  List<CheckAccountListItem>? filteredCheckAccounts = [];
  @observable
  CheckAccountListItem? selectedCheckAccount;

  @observable
  CheckAccountSummaryModel? checkAccountSummary;

  _CheckAccountsViewModelBase(
      this.checkId, this.transferAll, this.menuItems, this.type);

  @override
  void setContext(BuildContext buildContext) =>
      this.buildContext = buildContext;
  @override
  void init() {
    checkAccountService = CheckAccountService(networkManager!.networkManager);
    checkService = CheckService(networkManager!.networkManager);
    authStore = buildContext!.read<AuthStore>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCheckAccounts();
    });
  }

  @action
  Future getCheckAccounts() async {
    EasyLoading.show(
      status: 'Lütfen bekleyin...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    List<int> checkAccountTypeIds = [];
    checkAccounts = await checkAccountService.getCheckAccounts(
      GetCheckAccountsInput(
          branchId: authStore.user!.branchId,
          checkAccountTypeIds: checkAccountTypeIds),
    );

    if (checkId != null && checkId! > 0) {
      if (type == CheckAccountsPageType.Check) {
        checkAccounts =
            checkAccounts!.where((x) => x.checkAccountTypeId == 1).toList();
        checkAccounts = checkAccounts;
        filteredCheckAccounts = checkAccounts;
        changeSelectedType(1);
      } else if (type == CheckAccountsPageType.Unpayable) {
        checkAccounts = checkAccounts!
            .where((x) =>
                x.checkAccountTypeId == 8 ||
                x.checkAccountTypeId == 9 ||
                x.checkAccountTypeId == 10)
            .toList();
        checkAccounts = checkAccounts;
        filteredCheckAccounts = checkAccounts;
        changeSelectedType(0);
      }
    } else {
      checkAccounts = checkAccounts;
      filteredCheckAccounts = checkAccounts;
      changeSelectedType(1);
    }

    EasyLoading.dismiss();
    if (checkAccounts == null) {
      navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }

    EasyLoading.dismiss();
  }

  @action
  changeSelectedType(int val) {
    selectedType = val;
    filterCheckAccounts(searchCtrl.text);
  }

  @action
  void filterCheckAccounts(String text) {
    if (selectedType != 0) {
      filteredCheckAccounts = checkAccounts!
          .where((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()) &&
              element.checkAccountTypeId == selectedType)
          .toList();
    } else {
      filteredCheckAccounts = checkAccounts!
          .where((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
  }

  Future showCheckAccountDetailsDialog(int checkAccountId) async {
    int? res = await showDialog(
        builder: (context) =>
            CheckAccountDetailPage(type: type, checkAccountId: checkAccountId),
        context: buildContext!,
        barrierDismissible: false);
    if (res != null) {
      await getCheckAccounts();
      filterCheckAccounts(searchCtrl.text);
      for (var item in checkAccounts!) {
        if (item.checkAccountId == res) selectCheckAccount(item);
      }
    }
  }

  bool isAccountSelected(CheckAccountListItem item) {
    if (selectedCheckAccount != null &&
        selectedCheckAccount!.checkAccountId == item.checkAccountId) {
      return true;
    }
    return false;
  }

  @action
  void selectCheckAccount(CheckAccountListItem item) {
    if (type == CheckAccountsPageType.Check ||
        type == CheckAccountsPageType.CheckCustomer ||
        type == CheckAccountsPageType.Unpayable) {
      selectedCheckAccount = item;
    } else if (type == CheckAccountsPageType.CheckAccount) {
      selectedCheckAccount = item;
      getCheckAccountSummary();
    }
  }

  @action
  getCheckAccountSummary() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkAccountSummary = await checkAccountService
        .getCheckAccountSummary(selectedCheckAccount!.checkAccountId);
    EasyLoading.dismiss();
  }

  void navigateToCheckAccountTransactions(int? checkAccountId) async {
    await navigation.navigateToPage(
        path: NavigationConstants.CHECK_ACCOUNT_TRANSACTIONS,
        data: CheckAccountTransactionsArguments(
          checkAccountId: checkAccountId,
        ));
    await getCheckAccounts();
    if (selectedCheckAccount != null) getCheckAccountSummary();
  }

  @action
  Future insertCheckAccountTransaction(
      int checkAccountTransactionTypeId) async {
    if (selectedCheckAccount != null) {
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
        checkAccountId: selectedCheckAccount!.checkAccountId,
        checkAccountTransactionTypeId: checkAccountTransactionTypeId,
        terminalUserId: authStore.user!.terminalUserId!,
      ));
      EasyLoading.dismiss();
      if (tr!.value! > 0) {
        await getCheckAccountSummary();
        updateCheckAccountBalance(
            selectedCheckAccount!.checkAccountId, checkAccountSummary!.balance);
        priceCtrl.text = '';
      }
    }
  }

  @action
  void updateCheckAccountBalance(int? checkAccountId, double? newBalance) {
    for (var acc in checkAccounts!) {
      if (acc.checkAccountId == checkAccountId) {
        acc.balance = newBalance;
        break;
      }
    }

    checkAccounts = checkAccounts;
  }

  @action
  void getPercentage() {
    priceCtrl.text = (selectedCheckAccount!.balance!.abs() *
            (double.parse(priceCtrl.text).abs()) /
            100)
        .abs()
        .toStringAsFixed(2);
  }

  Future changeCheckCustomer() async {
    if (selectedCheckAccount != null) {
      if (checkId! > 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkService.changeCheckCustomer(checkId,
            selectedCheckAccount!.checkAccountId, authStore.user!.branchId!);
        EasyLoading.dismiss();
        if (res != null) {
          if (authStore.settings!.autoLock!) {
            await navigation.navigateToPage(
                path: NavigationConstants.LOGIN_VIEW);
          } else {
            await navigation.navigateToPage(
                path: NavigationConstants.HOME_VIEW);
          }
        }
      } else {
        Navigator.pop(buildContext!, selectedCheckAccount!.checkAccountId);
      }
    }
  }

  Future transferCheckToCheckAccount() async {
    if (selectedCheckAccount != null) {
      TransferCheckToCheckAccountInput inp = TransferCheckToCheckAccountInput(
        checkAccountId: selectedCheckAccount!.checkAccountId,
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
          await navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
        } else {
          await navigation.navigateToPage(path: NavigationConstants.HOME_VIEW);
        }
      }
    }
  }

  Future closeUnpayableCheck() async {
    if (selectedCheckAccount != null) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await checkService.closeUnpayableCheck(
        checkId,
        selectedCheckAccount!.checkAccountId,
        authStore.user!.branchId!,
        authStore.user!.terminalUserId!,
      );
      EasyLoading.dismiss();
      if (res != null) {
        if (authStore.settings!.autoLock!) {
          await navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
        } else {
          await navigation.navigateToPage(path: NavigationConstants.HOME_VIEW);
        }
      }
    }
  }

  @action
  Future removeCheckAccount() async {
    var res = await openYesNoDialog(buildContext!,
        '${selectedCheckAccount!.name} adlı cari hesap kaldırılacak. Onaylıyor musunuz?');
    if (res) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var ress = await checkAccountService
          .removeCheckAccount(selectedCheckAccount!.checkAccountId!);
      EasyLoading.dismiss();
      if (ress != null) {
        getCheckAccounts();
        selectedCheckAccount = null;
      }
    }
  }

  Future markCheckAccountUnpayable() async {
    var res = await openYesNoDialog(buildContext!,
        '${selectedCheckAccount!.name} adlı cari hesap ödenmeze atılacak. Onaylıyor musunuz?');
    if (res) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var ress = await checkAccountService
          .markCheckAccountUnpayable(selectedCheckAccount!.checkAccountId!);
      EasyLoading.dismiss();
      if (ress != null) getCheckAccounts();
    }
  }

  Future transferCheckAccountToCheckAccount() async {
    var res = await showDialog(
      context: buildContext!,
      builder: (context) => SelectCheckAccountPage(
        checkAccountId: selectedCheckAccount!.checkAccountId!,
        transferAll: true,
      ),
    );
    if (res != null) {
      await getCheckAccounts();
      selectedCheckAccount = null;
    }
  }

  void closePage() {
    Navigator.pop(buildContext!);
  }
}

class CheckAccountType {
  int value;
  String name;

  CheckAccountType({required this.name, required this.value});
}
