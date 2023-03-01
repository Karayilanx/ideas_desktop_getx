import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/table_model.dart';

class TableService extends BaseGetConnect {
  Future<TableWithDetails?> getTableDetails(int? tableId) async {
    Response? response;
    try {
      response = await get('table/getTableDetails', query: {
        'tableId': tableId.toString(),
      });
      return TableWithDetails.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> getActiveCheckIdByTableId(int? tableId) async {
    Response? response;
    try {
      response = await get('table/getActiveCheckIdByTableId', query: {
        'tableId': tableId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
