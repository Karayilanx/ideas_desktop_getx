import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/branch_model.dart';
import 'package:ideas_desktop_getx/service/branch/branch_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';

import '../../../order-detail/component/discount_dialog.dart';

class CreateTerminalUserController extends BaseController {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  TextEditingController maxDiscountPercentageCtrl = TextEditingController();

  Rx<TerminalUserModel> model = Rx<TerminalUserModel>(TerminalUserModel(
    branchId: -1,
    canCancel: true,
    canDiscount: true,
    canEndDay: true,
    canGift: true,
    canMakeCheckPayment: true,
    canMarkUnpayable: true,
    canRestoreCheck: true,
    canSeeActions: true,
    canTransferCheck: true,
    isActive: true,
    maxDiscountPercentage: 100,
    canSendCheckToCheckAccount: true,
    pin: '',
    name: '',
    isAdmin: false,
  ));

  BranchService branchService = Get.find();
  ServerService serverService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      model.value.branchId = authStore.user!.serverBranchId;
    });
  }

  changeCanGift(bool val) {
    model.update((vall) {
      vall!.canGift = val;
    });
  }

  changeCanDiscount(bool val) {
    model.update((vall) {
      vall!.canDiscount = val;
    });
  }

  changeCanCancel(bool val) {
    model.update((vall) {
      vall!.canCancel = val;
    });
  }

  changeCanEndDay(bool val) {
    model.update((vall) {
      vall!.canEndDay = val;
    });
  }

  changeCanMakeCheckPayment(bool val) {
    model.update((vall) {
      vall!.canMakeCheckPayment = val;
    });
  }

  changeCanMarkUnpayable(bool val) {
    model.update((vall) {
      vall!.canMarkUnpayable = val;
    });
  }

  changeCanRestoreCheck(bool val) {
    model.update((vall) {
      vall!.canRestoreCheck = val;
    });
  }

  changeCanSeeActions(bool val) {
    model.update((vall) {
      vall!.canSeeActions = val;
    });
  }

  changeCanSendCheckToCheckAccount(bool val) {
    model.update((vall) {
      vall!.canSendCheckToCheckAccount = val;
    });
  }

  changeCanTransferCheck(bool val) {
    model.update((vall) {
      vall!.canTransferCheck = val;
    });
  }

  changeIsAdmin(bool val) {
    model.update((vall) {
      vall!.isAdmin = val;
    });
  }

  Future createTerminalUser() async {
    if (nameCtrl.text.isEmpty) {
      showSnackbarError('Kullanıcı ismi zorunludur.');
      return;
    } else if (pinCtrl.text.isEmpty) {
      showSnackbarError('Şifre zorunludur.');
      var pin = int.tryParse(pinCtrl.text);
      if (pin == null || pinCtrl.text.length != 4) {
        showSnackbarError('Şifre 4 haneli sayı olmak zorundadır!');
      }
      return;
    } else {
      var disc = int.tryParse(discountCtrl.text);
      if (disc != null) {
        model.value.maxDiscountPercentage = disc;
      } else {
        model.value.maxDiscountPercentage = 100;
      }
    }

    model.value.name = nameCtrl.text;
    model.value.pin = pinCtrl.text;

    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await branchService.createTerminalUser(model.value);
    if (res != null && res.value == 1) {
      var syncRes = await serverService.syncChanges(authStore.user!.branchId!);
      EasyLoading.dismiss();

      if (syncRes != null) {
        Get.back();
      } else {
        showSnackbarError(
            'Ön kasa kullanıcı değişiklikleri sırasında bir hata oluştu! Lütfen tekrar deneyiniz!');
      }
    } else {
      showSnackbarError('Kullanıcı kaydedilirken bir hata oluştu!');
    }

    EasyLoading.dismiss();
  }
}
