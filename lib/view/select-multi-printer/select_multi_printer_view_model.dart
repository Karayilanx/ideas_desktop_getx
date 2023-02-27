import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../model/printer_model.dart';
import '../../service/printer/printer_service.dart';

class SelectMultiPrinterController extends BaseController {
  PrinterService printerService = Get.find();
  List<String> printerIds = Get.arguments;
  RxList<PrinterOutput> printers = RxList<PrinterOutput>([]);
  RxList<PrinterOutput> selectedPrinters = RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrinters();
      getPrinterIds();
    });
  }

  void getPrinterIds() {
    for (var element in printerIds) {
      var id = int.parse(element);
      selectPrinter(printers.where((element) => element.printerId == id).first);
    }
  }

  Future getPrinters() async {
    var res = await printerService.getPrinters(authStore.user!.branchId);
    if (res != null) {
      printers(res);
    } else {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }
  }

  bool isPrinterSelected(PrinterOutput pr) {
    return selectedPrinters
        .where((element) => element.printerId == pr.printerId)
        .isNotEmpty;
  }

  void selectPrinter(PrinterOutput pr) {
    if (!isPrinterSelected(pr)) {
      selectedPrinters.add(pr);
    } else {
      selectedPrinters.remove(pr);
    }
    selectedPrinters(selectedPrinters);
  }
}
