import 'package:get/get.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/check_account_model.dart';
import '../../model/integer_model.dart';

class CheckAccountService extends BaseGetConnect {
  Future<IntegerModel?> createCheckAccount(
      CreateCheckAccountInput input) async {
    Response? response;
    try {
      response = await post('checkAccount/createCheckAccount', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CheckAccountListItem>?> getCheckAccounts(
      GetCheckAccountsInput input) async {
    Response? response;
    try {
      response = await post('checkAccount/getCheckAccounts', input.toJson());
      return response.body
          .map((data) => CheckAccountListItem.fromJson(data))
          .cast<CheckAccountListItem>()
          .toList() as List<CheckAccountListItem>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> transferCheckToCheckAccount(
      TransferCheckToCheckAccountInput input) async {
    Response? response;
    try {
      response = await post(
          'checkAccount/transferCheckToCheckAccount', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetCheckAccountTransactionsOutput?> getCheckAccountTransactions(
      int? checkAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/getCheckAccountTransactions', query: {
        'checkAccountId': checkAccountId.toString(),
      });
      return GetCheckAccountTransactionsOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> removeCheckAccountTransaction(
      int? checkAccountTransactionId) async {
    Response? response;
    try {
      response =
          await get('checkAccount/removeCheckAccountTransaction', query: {
        'checkAccountTransactionId': checkAccountTransactionId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckAccountSummaryModel?> getCheckAccountSummary(
      int? checkAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/getCheckAccountSummary', query: {
        'checkAccountId': checkAccountId.toString(),
      });
      return CheckAccountSummaryModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> insertCheckAccountTransaction(
      CheckAccountTransactionModel input) async {
    Response? response;
    try {
      response = await post(
          'checkAccount/insertCheckAccountTransaction', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> removeCheckAccount(int checkAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/removeCheckAccount', query: {
        'checkAccountId': checkAccountId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> transferCheckAccount(
      int checkAccountId, int targetCheckAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/transferCheckAccount', query: {
        'checkAccountId': checkAccountId.toString(),
        'targetCheckAccountId': targetCheckAccountId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> markCheckAccountUnpayable(int checkAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/markCheckAccountUnpayable', query: {
        'checkAccountId': checkAccountId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> transferCheckAccountTransaction(
      int checkAccountId, int targetCheckAccountId, int? endOfDayId) async {
    Response? response;
    try {
      response =
          await get('checkAccount/transferCheckAccountTransaction', query: {
        'checkAccountId': checkAccountId.toString(),
        'targetCheckAccountId': targetCheckAccountId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> editCheckAccount(CreateCheckAccountInput input) async {
    Response? response;
    try {
      response = await post('checkAccount/editCheckAccount', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CreateCheckAccountInput?> getCheckAccountDetails(
      int checkAccountId) async {
    Response? response;
    try {
      response = await get('checkAccount/getCheckAccountDetails', query: {
        'checkAccountId': checkAccountId.toString(),
      });
      return CreateCheckAccountInput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
