import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ideas_desktop/service/base_get_connect.dart';

import '../model/login_input.dart';
import '../model/terminal_user.dart';

class LoginService extends BaseGetConnect {
  // Get request
  Future<TerminalUser?> loginTerminal(LoginInput input) async {
    Response? response;
    try {
      response = await post(
        'auth/loginTerminal',
        input.toJson(),
      );

      return TerminalUser.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<TerminalUser>?> getTerminalUsers(int branchId) async {
    Response? response;
    try {
      response = await get(
        'auth/getTerminalUsers',
        query: {
          'branchId': branchId.toString(),
        },
      );

      return response.body
          .map((data) => TerminalUser.fromJson(data))
          .cast<TerminalUser>()
          .toList() as List<TerminalUser>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
