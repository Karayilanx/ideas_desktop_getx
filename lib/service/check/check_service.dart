import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/cancel_note_model.dart';
import '../../model/check_model.dart';

class CheckService extends BaseGetConnect {
  Future<CheckDetailsModel?> getCheckDetails(int? checkId, int branchId) async {
    Response? response;
    try {
      response = await get('check/getCheckDetails', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
      });
      return CheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckDetailsModel?> getFastSellCheck(int branchId) async {
    Response? response;
    try {
      response = await get('check/getFastSellCheck', query: {
        'branchId': branchId.toString(),
      });
      return CheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> sendOrder(CheckDetailsModel check) async {
    Response? response;
    try {
      response = await post('check/sendOrder', check.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckPaymentResultOutput?> makeCheckPayment(
      CheckPaymentModel payment) async {
    Response? response;
    try {
      response = await post('check/makeCheckPayment', payment.toJson());
      return CheckPaymentResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> cancelCheckItem(CancelCheckItemInput input) async {
    Response? response;
    try {
      response = await post('check/cancelCheckItem', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> transferOrders(TransferOrdersInput input) async {
    Response? response;
    try {
      response = await post('check/transferOrders', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<ClosedCheckListItem>?> getTodaysClosedChecks(int branchId) async {
    Response? response;
    try {
      response = await get('check/getTodaysClosedChecks', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => ClosedCheckListItem.fromJson(data))
          .cast<ClosedCheckListItem>()
          .toList() as List<ClosedCheckListItem>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> restoreCheck(
      int? checkId, int branchId, int terminalUserId) async {
    Response? response;
    try {
      response = await get('check/restoreCheck', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateCheckNote(UpdateCheckNoteInput input) async {
    Response? response;
    try {
      response = await post('check/updateCheckNote', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> cancelDiscounts(
      int? checkId, int? terminalUserId, int branchId) async {
    Response? response;
    try {
      response = await get('check/cancelDiscounts', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> cancelPayments(
      int? checkId, int? terminalUserId, int branchId) async {
    Response? response;
    try {
      response = await get('check/cancelPayments', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> cancelCheck(
      int? checkId, int? terminalUserId, int branchId) async {
    Response? response;
    try {
      response = await get('check/cancelCheck', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> addConstantDiscount(int? checkId, int? terminalUserId,
      double? percentage, int branchId) async {
    Response? response;
    try {
      response = await get('check/addConstantDiscount', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'percentage': percentage.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> changeCheckCustomer(
      int? checkId, int? checkAccountId, int branchId) async {
    Response? response;
    try {
      response = await get('check/changeCheckCustomer', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'checkAccountId': checkAccountId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> clearCheckCustomer(int? checkId, int branchId) async {
    Response? response;
    try {
      response = await get('check/clearCheckCustomer', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> changeWaiter(
      int? checkId, int? terminalUserId, int branchId) async {
    Response? response;
    try {
      response = await get('check/changeWaiter', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> markUnpayable(int? checkId, int branchId) async {
    Response? response;
    try {
      response = await get('check/markUnpayable', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> addServiceCharge(int? checkId, int? terminalUserId,
      double? serviceCharge, int branchId) async {
    Response? response;
    try {
      response = await get('check/addServiceCharge', query: {
        'checkId': checkId.toString(),
        'serviceCharge': serviceCharge.toString(),
        'terminalUserId': terminalUserId.toString(),
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> cancelBillSent(
      int? checkId, int? terminalUserId, int branchId) async {
    Response? response;
    try {
      response = await get('check/cancelBillSent', query: {
        'checkId': checkId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> closeUnpayableCheck(int? checkId, int? checkAccountId,
      int branchId, int terminalUserId) async {
    Response? response;
    try {
      response = await get('check/closeUnpayableCheck', query: {
        'checkId': checkId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'branchId': branchId.toString(),
        'checkAccountId': checkAccountId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CancelNoteOutput>?> getCancelNotes(int branchId) async {
    Response? response;
    try {
      response = await get('check/getCancelNotes', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => CancelNoteOutput.fromJson(data))
          .cast<CancelNoteOutput>()
          .toList() as List<CancelNoteOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckDetailsModel?> getPastCheckDetails(
      int? checkId, int branchId, int endOfDayId) async {
    Response? response;
    try {
      response = await get('check/getPastCheckDetails', query: {
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });

      return CheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<RequestsModel?> getRequests(int branchId) async {
    Response? response;
    try {
      response = await get('check/getRequests', query: {
        'branchId': branchId.toString(),
      });

      return RequestsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> rejectCancelRequest(
      int checkMenuItemCancelRequestId) async {
    Response? response;
    try {
      response = await get('check/rejectCancelRequest', query: {
        'checkMenuItemCancelRequestId': checkMenuItemCancelRequestId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> confirmCancelRequest(
      int checkMenuItemCancelRequestId, int terminalUserId) async {
    Response? response;
    try {
      response = await get('check/confirmCancelRequest', query: {
        'checkMenuItemCancelRequestId': checkMenuItemCancelRequestId.toString(),
        'terminalUserId': terminalUserId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> confirmWaiterRequest(
      int branchId, int serverTableId, int terminalUserId) async {
    Response? response;
    try {
      response = await get('check/confirmWaiterRequest', query: {
        'branchId': branchId.toString(),
        'terminalUserId': terminalUserId.toString(),
        'serverTableId': serverTableId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> changeCheckMenuItemPrice(ChangePriceModel input) async {
    Response? response;
    try {
      response = await post('check/changeCheckMenuItemPrice', input.toJson());

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CheckLogModel>?> getLocalCheckLogs(
      int branchId, int checkId) async {
    Response? response;
    try {
      response = await get('check/getLocalCheckLogs', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
      });

      return response.body
          .map((data) => CheckLogModel.fromJson(data))
          .cast<CheckLogModel>()
          .toList() as List<CheckLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<OrderLogModel>?> getLocalOrderLogs(
      int branchId, int checkId) async {
    Response? response;
    try {
      response = await get('check/getLocalOrderLogs', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
      });

      return response.body
          .map((data) => OrderLogModel.fromJson(data))
          .cast<OrderLogModel>()
          .toList() as List<OrderLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<OrderLogModel>?> getLocalPastOrderLogs(
      int branchId, int checkId, int endOfDayId) async {
    Response? response;
    try {
      response = await get('check/getLocalPastOrderLogs', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });

      return response.body
          .map((data) => OrderLogModel.fromJson(data))
          .cast<OrderLogModel>()
          .toList() as List<OrderLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CheckLogModel>?> getLocalPastCheckLogs(
      int branchId, int checkId, int endOfDayId) async {
    Response? response;
    try {
      response = await get('check/getLocalPastCheckLogs', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });

      return response.body
          .map((data) => CheckLogModel.fromJson(data))
          .cast<CheckLogModel>()
          .toList() as List<CheckLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> giveTableToName(
      int branchId, int checkId, String name) async {
    Response? response;
    try {
      response = await get('check/giveTableToName', query: {
        'branchId': branchId.toString(),
        'checkId': checkId.toString(),
        'name': name.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
