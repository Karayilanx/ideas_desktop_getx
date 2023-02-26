import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/navigation/check_accounts_navigation_args.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../model/check_account_model.dart';
import '../../../../service/check_account/check_account_service.dart';

class CheckAccountDetailController extends BaseController {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController taxOfficeCtrl = TextEditingController();
  final TextEditingController taxNoCtrl = TextEditingController();
  final TextEditingController discountCtrl = TextEditingController(text: "0");

  final CheckAccountsPageType? type = Get.arguments[0];
  final int checkAccountId = Get.arguments[1];
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  RxInt checkAccountTypeId = RxInt(1);
  CheckAccountService checkAccountService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    if (checkAccountId > 0) {
      var res =
          await checkAccountService.getCheckAccountDetails(checkAccountId);
      if (res != null) {
        addressCtrl.text = res.checkAccountAddress!;
        phoneCtrl.text = res.phoneNumber!;
        nameCtrl.text = res.name!;
        taxNoCtrl.text = res.taxNo!;
        taxOfficeCtrl.text = res.taxOffice!;
        checkAccountTypeId.value = res.checkAccountTypeId!;
        discountCtrl.text = res.discountPercentage.toString();
      }
      if (type == CheckAccountsPageType.Unpayable) {
        checkAccountTypeId.value = 8;
      }
    }
  }

  Future createCheckAccount() async {
    CreateCheckAccountInput inp = CreateCheckAccountInput(
      branchId: authStore.user!.branchId!,
      checkAccountAddress: addressCtrl.text,
      phoneNumber: maskFormatter.getUnmaskedText(),
      name: nameCtrl.text,
      taxNo: taxNoCtrl.text,
      taxOffice: taxOfficeCtrl.text,
      checkAccountTypeId: checkAccountTypeId.value,
      checkAccountId: checkAccountId,
      discountPercentage: discountCtrl.text.getDouble ?? 0,
    );
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    IntegerModel? res;
    if (checkAccountId > 0) {
      res = await checkAccountService.editCheckAccount(inp);
    } else {
      res = await checkAccountService.createCheckAccount(inp);
    }
    EasyLoading.dismiss();
    if (res != null) {
      Get.back(result: res.value);
    }
  }

  void changeCheckAccountType(int? id) {
    checkAccountTypeId(id);
  }
}
