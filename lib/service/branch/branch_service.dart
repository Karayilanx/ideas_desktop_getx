import 'package:get/get.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/branch_model.dart';
import '../../model/integer_model.dart';
import '../../model/settings_model.dart';

class BranchService extends BaseGetConnect {
  Future<SettingsModel?> getSettings(int branchId) async {
    Response? response;
    try {
      response = await get('branch/getSettings',
          query: {'branchId': branchId.toString()});

      return SettingsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<NetworkInfoModel>?> getNetworkInfo() async {
    Response? response;
    try {
      response = await get('branch/getNetworkInfo');

      return response.body
          .map((data) => NetworkInfoModel.fromJson(data))
          .cast<NetworkInfoModel>()
          .toList() as List<NetworkInfoModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> getServerBranchId(int branchId) async {
    Response? response;
    try {
      response = await get('branch/getServerBranchId',
          query: {'branchId': branchId.toString()});

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<TerminalUserModel>?> getTerminalUsers(int branchId) async {
    Response? response;
    try {
      response = await get('branch/getTerminalUsers', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => TerminalUserModel.fromJson(data))
          .cast<TerminalUserModel>()
          .toList() as List<TerminalUserModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateTerminalUsers(
      UpdateTerminalUsersModel input) async {
    Response? response;
    try {
      response = await post(
        'branch/updateTerminalUsers',
        input.toJson(),
      );

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> createTerminalUser(TerminalUserModel input) async {
    Response? response;
    try {
      response = await post(
        'branch/createTerminalUser',
        input.toJson(),
      );

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
