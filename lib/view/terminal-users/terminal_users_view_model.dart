import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/branch_model.dart';
import 'package:ideas_desktop/service/branch/branch_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/view/terminal-users/create-terminal-user/view/create_terminal_user_view.dart';
import 'package:ideas_desktop/view/terminal-users/terminal_users_table.dart';

class TerminalUsersController extends BaseController {
  BranchService branchService = Get.find();
  ServerService serverService = Get.find();

  TextEditingController searchCtrl = TextEditingController();

  RxBool hideSearch = RxBool(true);
  RxList<TerminalUserModel> filteredTerminalUsersModel = RxList([]);
  Rx<TerminalUsersDataSource?> terminalUsersDataSource =
      Rx<TerminalUsersDataSource?>(null);
  RxList<TerminalUserModel> terminalUsersModel = RxList([]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTerminalUsers();
    });
  }

  Future getTerminalUsers() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    terminalUsersModel(
        await branchService.getTerminalUsers(authStore.user!.serverBranchId!));

    filteredTerminalUsersModel(terminalUsersModel);
    terminalUsersDataSource(TerminalUsersDataSource(
      menuItems: filteredTerminalUsersModel,
    ));

    EasyLoading.dismiss();
  }

  changeIsActive(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.isActive = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanGift(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canGift = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanMarkUnpayable(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canMarkUnpayable = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanDiscount(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canDiscount = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeIsAdmin(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.isAdmin = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanTransferCheck(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canTransferCheck = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanRestoreCheck(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canRestoreCheck = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanSendCheckToCheckAccount(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canSendCheckToCheckAccount = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanMakeCheckPayment(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canMakeCheckPayment = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanCancel(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canCancel = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanEndDay(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canEndDay = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  changeCanSeeActions(int terminalUserId, bool val) {
    var tempSort = terminalUsersDataSource.value!.sortedColumns;
    var item = terminalUsersModel
        .where((element) => element.terminalUserId == terminalUserId)
        .first;
    item.canSeeActions = val;
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
    terminalUsersDataSource.value!.sortedColumns.addAll(tempSort);
    terminalUsersDataSource.value!.sort();
  }

  void filterTerminalUsers() {
    filteredTerminalUsersModel(terminalUsersModel
        .where((element) =>
            element.name!.toUpperCase().contains(searchCtrl.text.toUpperCase()))
        .toList());
    terminalUsersDataSource(
        TerminalUsersDataSource(menuItems: filteredTerminalUsersModel));
  }

  changeName(int terminalUserId, String newName) {
    for (var i = 0; i < terminalUsersModel.length; i++) {
      var item = terminalUsersModel[i];
      if (item.terminalUserId == terminalUserId) {
        item.name = newName;
      }
    }
  }

  changePin(int terminalUserId, String newPin) {
    for (var i = 0; i < terminalUsersModel.length; i++) {
      var item = terminalUsersModel[i];
      if (item.terminalUserId == terminalUserId) {
        item.pin = newPin;
      }
    }
  }

  changeMaxDiscountPercentage(int terminalUserId, String newPercentage) {
    for (var i = 0; i < terminalUsersModel.length; i++) {
      var item = terminalUsersModel[i];
      if (item.terminalUserId == terminalUserId) {
        var perc = int.tryParse(newPercentage);
        item.maxDiscountPercentage = perc;
      }
    }
  }

  showCreateTerminalUserDialog() async {
    await Get.dialog(
      const CreateTerminalUserPage(),
      barrierDismissible: true,
    );
    await getTerminalUsers();
  }

  Future updateTerminalUsers() async {
    try {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await branchService.updateTerminalUsers(
          UpdateTerminalUsersModel(
              branchId: authStore.user!.serverBranchId!,
              terminalUsers: terminalUsersModel));
      if (result != null && result.value == 1) {
        await getTerminalUsers();
        terminalUsersDataSource.value!.sort();

        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await serverService.syncChanges(authStore.user!.branchId!);
        EasyLoading.dismiss();

        if (res != null) {
          showSnackbarError(
              'Ön kasa kullanıcı değişiklikleri başarıyla kaydedildi!');
        } else {
          showSnackbarError(
              'Ön kasa kullanıcı değişiklikleri sırasında bir hata oluştu! Lütfen tekrar deneyiniz!');
        }
      } else {
        showSnackbarError(
            'Ön kasa kullanıcı değişiklikleri sırasında bir hata oluştu! Lütfen tekrar deneyiniz!');
      }
      EasyLoading.dismiss();
    } on Exception {
      EasyLoading.dismiss();
    }
  }
}
