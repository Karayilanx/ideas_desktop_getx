import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ideas_desktop/model/branch_model.dart';
import 'package:ideas_desktop/model/integer_model.dart';
import 'package:ideas_desktop/service/base_get_connect.dart';

class ServerService extends BaseGetConnect {
  Future<IntegerModel?> syncChanges(int branchId) async {
    Response? response;
    try {
      response = await get('server/syncServerChanges',
          query: {'branchId': branchId.toString()});

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckServerChangesModel?> checkServerChanges(int branchId) async {
    Response? response;
    try {
      response = await get('server/checkServerChanges',
          query: {'branchId': branchId.toString()});

      return CheckServerChangesModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> doStartupOperations(int branchId) async {
    Response? response;
    try {
      response = await get('server/doStartupOperations',
          query: {'branchId': branchId.toString()});

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
