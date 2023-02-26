import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../model/check_account_model.dart';
import '../../../../service/check/check_service.dart';
import '../../../../service/check_account/check_account_service.dart';
import '../../../authentication/auth_store.dart';
import '../viewmodel/check_accounts_view_model.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'select_check_account_view_model.g.dart';

class SelectCheckAccountViewModel = _SelectCheckAccountViewModelBase
    with _$SelectCheckAccountViewModel;

abstract class _SelectCheckAccountViewModelBase with Store, BaseViewModel {
  final bool transferAll;
  late CheckAccountService checkAccountService;
  late CheckService checkService;
  late AuthStore authStore;
  int checkAccountId;
  int? endOfDayId;
  TextEditingController searchCtrl = TextEditingController();

  @observable
  int selectedType = 1;
  @observable
  List<CheckAccountListItem>? checkAccounts = [];
  @observable
  List<CheckAccountListItem>? filteredCheckAccounts = [];
  @observable
  CheckAccountListItem? selectedCheckAccount;

  final List<CheckAccountType> types = [
    CheckAccountType(name: 'Hepsi', value: 0),
    CheckAccountType(name: 'Müşteri', value: 1),
    CheckAccountType(name: 'Tedarikçi', value: 2),
    CheckAccountType(name: 'Banka/POS', value: 5),
    CheckAccountType(name: 'Kasa', value: 6),
    CheckAccountType(name: 'Ödenmez', value: 8),
  ];

  _SelectCheckAccountViewModelBase({
    required this.checkAccountId,
    required this.transferAll,
    // ignore: unused_element
    this.endOfDayId,
  });

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
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    List<int> checkAccountTypeIds = [];
    checkAccounts = await checkAccountService.getCheckAccounts(
      GetCheckAccountsInput(
          branchId: authStore.user!.branchId,
          checkAccountTypeIds: checkAccountTypeIds),
    );
    checkAccounts = checkAccounts;
    filteredCheckAccounts = checkAccounts;
    EasyLoading.dismiss();
    if (checkAccounts == null) {
      navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }
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

  bool isAccountSelected(CheckAccountListItem item) {
    if (selectedCheckAccount != null &&
        selectedCheckAccount!.checkAccountId == item.checkAccountId) {
      return true;
    }
    return false;
  }

  @action
  void selectCheckAccount(CheckAccountListItem item) {
    selectedCheckAccount = item;
  }

  void save() async {
    if (selectedCheckAccount != null) {
      if (transferAll) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkAccountService.transferCheckAccount(
            checkAccountId, selectedCheckAccount!.checkAccountId!);
        EasyLoading.dismiss();
        if (res != null) Navigator.pop(buildContext!, true);
      } else {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkAccountService.transferCheckAccountTransaction(
            checkAccountId, selectedCheckAccount!.checkAccountId!, endOfDayId);
        EasyLoading.dismiss();
        if (res != null) Navigator.pop(buildContext!, true);
      }
    }
  }

  void closePage() {
    Navigator.pop(buildContext!);
  }
}
