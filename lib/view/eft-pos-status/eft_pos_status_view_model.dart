import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/model/check_model.dart';
import 'package:ideas_desktop_getx/model/eft_pos_model.dart';
import 'package:ideas_desktop_getx/service/eft_pos/eft_pos_service.dart';
import 'package:ideas_desktop_getx/view/eft-pos-status/eft_pos_status_view.dart';

class EftPosStatusController extends BaseController {
  final int eftPosId = Get.arguments[0];
  final int checkId = Get.arguments[1];
  final CheckPaymentTypeEnum checkPaymentType = Get.arguments[2];
  final bool total = Get.arguments[3];
  final double remaining = Get.arguments[4];

  EftPosService eftPosService = Get.find();

  RxBool paymentStart = RxBool(false);
  Rx<Status> connectionStatus = Rx<Status>(Status.LOADING);
  Rx<Status> startReceiptStatus = Rx<Status>(Status.LOADING);
  Rx<Status> saleStatus = Rx<Status>(Status.LOADING);
  Rx<Status> closeStatus = Rx<Status>(Status.LOADING);
  RxList<OkcDeptModel> departments = RxList<OkcDeptModel>([]);

  List<TextEditingController> controllers = [];

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (total) {
        await makePayment();
      } else {
        await getDepartments();
      }
    });
  }

  makePayment() async {
    changeStartPayment(true);
    var connectRes =
        await eftPosService.connectEftPos(authStore.user!.branchId!, eftPosId);
    if (connectRes == null) {
      changeConnectionStatus(Status.ERROR);
      changeStartPayment(false);
      return;
    } else {
      changeConnectionStatus(Status.OK);
    }

    var startReceipeRes = await eftPosService.startReceipt(eftPosId);
    if (startReceipeRes == null) {
      changeStartReceiptStatus(Status.ERROR);
      changeStartPayment(false);
      return;
    } else {
      changeStartReceiptStatus(Status.OK);
    }
    if (total) {
      var saleRes = await eftPosService.deptSellCheck(
          eftPosId, checkId, authStore.user!.branchId!, checkPaymentType.index);
      if (saleRes == null) {
        changesaleStatus(Status.ERROR);
        changeStartPayment(false);
        return;
      } else {
        changesaleStatus(Status.OK);
      }
    } else {
      List<DeptSellInput> inp = [];
      for (var i = 0; i < controllers.length; i++) {
        var controller = controllers[i];
        var dept = departments[i];
        var amount = controller.text.getDouble;
        if (amount == null || amount == 0) continue;
        inp.add(DeptSellInput(authStore.user!.branchId, eftPosId, dept.deptId,
            dept.deptName, amount, checkPaymentType.index));
      }

      var saleRes = await eftPosService.deptSell(inp);
      if (saleRes == null) {
        changesaleStatus(Status.ERROR);
        changeStartPayment(false);
        return;
      } else {
        changesaleStatus(Status.OK);
      }
    }

    var closeRes = await eftPosService.closeReceipt(
        eftPosId, checkId, checkPaymentType.index, remaining);
    if (closeRes == null) {
      changeCloseStatus(Status.ERROR);
      changeStartPayment(false);
      return;
    } else {
      changeCloseStatus(Status.OK);
      changeStartPayment(false);
      Get.back(result: true);
    }
    Get.back(result: true);
  }

  changeStartPayment(bool start) {
    paymentStart(start);
  }

  changeConnectionStatus(Status status) {
    connectionStatus(status);
  }

  changeStartReceiptStatus(Status status) {
    startReceiptStatus(status);
  }

  changesaleStatus(Status status) {
    saleStatus(status);
  }

  changeCloseStatus(Status status) {
    closeStatus(status);
  }

  voidReceipt() async {
    var res = await eftPosService.voidReceipt(eftPosId);
    if (res != null) {
      Get.back();
    }
  }

  getDepartments() async {
    departments(await eftPosService.getDepartments(eftPosId));
    if (departments != null) {
      controllers = [];
      for (var i = 0; i < departments.length; i++) {
        controllers.add(TextEditingController());
      }
    }
  }

  getRemainingAmount(TextEditingController ctrl) {
    for (var element in controllers) {
      element.text = "";
    }
    ctrl.text = remaining.toStringAsFixed(2);
  }

  checkAmount() {
    double inputAmount = 0;
    for (var element in controllers) {
      var amount = element.text.getDouble;
      if (amount == null) continue;
      inputAmount += amount;
    }
    if (inputAmount == remaining) {
      makePayment();
    } else {
      showSnackbarError(
          "Toplam tutar ${remaining.toStringAsFixed(2)} olacak şekilde departmanlara dağıtınız.");
    }
  }
}
