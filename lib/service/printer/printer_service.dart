import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/printer_model.dart';

class PrinterService extends BaseGetConnect {
  Future<IntegerModel?> printCheck(int? checkId, int? terminalUserId,
      String printerName, int branchId) async {
    Response? response;
    try {
      response = await get('printer/printCheck', query: {
        'checkId': checkId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printSlipCheck(int? checkId, int? terminalUserId,
      String printerName, int branchId, bool isGeneric) async {
    Response? response;
    try {
      response = await get('printer/printSlipCheck', query: {
        'checkId': checkId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
        'isGeneric': isGeneric.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printPastSlipCheck(int? checkId, int? terminalUserId,
      String printerName, int branchId, bool isGeneric, int endOfDayId) async {
    Response? response;
    try {
      response = await get('printer/printPastSlipCheck', query: {
        'checkId': checkId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
        'isGeneric': isGeneric.toString(),
        'endOfDayId': endOfDayId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printStoppedItems(PrintStoppedItemsInput input) async {
    Response? response;
    try {
      response = await post('printer/printStoppedItems', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<PrinterOutput>?> getPrinters(int? branchId) async {
    Response? response;
    try {
      response = await get('printer/getPrinters', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => PrinterOutput.fromJson(data))
          .cast<PrinterOutput>()
          .toList() as List<PrinterOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printYemeksepeti(
      String yemeksepetiId, String printerName, int branchId) async {
    Response? response;
    try {
      response = await get('printer/printYemeksepeti', query: {
        'yemeksepetiId': yemeksepetiId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printGetir(
      String getirId, String printerName, int branchId) async {
    Response? response;
    try {
      response = await get('printer/printGetir', query: {
        'yemeksepetiId': getirId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printClosedCheck(
      int? checkId, String printerName, int branchId) async {
    Response? response;
    try {
      response = await get('printer/printClosedCheck', query: {
        'checkId': checkId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printPastCheck(
      int? checkId, String printerName, int branchId, int endOfDayId) async {
    Response? response;
    try {
      response = await get('printer/printPastCheck', query: {
        'checkId': checkId.toString(),
        'printerName': printerName.toString(),
        'branchId': branchId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<PrinterOutput>?> getPrintersForEdit(int? servverBranchId) async {
    Response? response;
    try {
      response = await get('printer/getPrintersForEdit', query: {
        'branchId': servverBranchId.toString(),
      });
      return response.body
          .map((data) => PrinterOutput.fromJson(data))
          .cast<PrinterOutput>()
          .toList() as List<PrinterOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
