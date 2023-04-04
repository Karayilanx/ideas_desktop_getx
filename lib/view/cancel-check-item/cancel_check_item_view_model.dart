import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';

import '../../model/check_model.dart';
import '../../service/check/check_service.dart';
import '../fast-note/fast_note_view.dart';

class CancelCheckItemController extends BaseController {
  final int quantity = Get.arguments[0];
  final int checkId = Get.arguments[2];
  final GroupedCheckItem item = Get.arguments[1];

  final TextEditingController cancelNoteController =
      TextEditingController(text: '');

  CheckService checkService = Get.find();
  RxBool save = RxBool(false);

  Future cancelCheckItem(int cancelTypeId) async {
    CancelCheckItemInput input = CancelCheckItemInput(
      checkId: this.checkId,
      groupedCheckItem: item,
      cancelQuantity: quantity,
      terminalUserId: authStore.user!.terminalUserId,
      cancelNote: cancelNoteController.text,
      cancelTypeId: cancelTypeId,
      saveNote: save.value,
      branchId: authStore.user!.branchId!,
    );
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var checkId = await checkService.cancelCheckItem(input);
    EasyLoading.dismiss();
    if (checkId != null) {
      Get.back(result: true);
    }
  }

  Future openFastNotesDialog() async {
    var res = await Get.dialog(
      const FastNotePage(),
    );
    if (res != null) cancelNoteController.text = res;
  }
}
