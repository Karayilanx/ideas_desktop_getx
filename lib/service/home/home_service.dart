import 'package:get/get.dart';
import 'package:ideas_desktop/service/base_get_connect.dart';

import '../../model/home_model.dart';

class HomeService extends BaseGetConnect {
  Future<List<HomeGroupWithDetails>?> getHomeGroupsWithDetails(
      int branchId) async {
    Response? response;
    try {
      response = await get('home/getHomeGroupsWithDetails', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => HomeGroupWithDetails.fromJson(data))
          .cast<HomeGroupWithDetails>()
          .toList() as List<HomeGroupWithDetails>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
