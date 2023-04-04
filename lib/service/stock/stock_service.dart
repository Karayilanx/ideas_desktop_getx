import 'package:get/get.dart';
import 'package:ideas_desktop/model/integer_model.dart';
import 'package:ideas_desktop/service/base_get_connect.dart';

class StockService extends BaseGetConnect {
  Future<IntegerModel?> calculateEndOfDayStocks(
      int endOfDayId, int branchId) async {
    Response? response;
    try {
      response = await get('stockCalculate/calculateEndOfDayStocks', query: {
        'branchId': branchId.toString(),
        'endOfDayId': endOfDayId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> calculateStockCosts(int branchId) async {
    Response? response;
    try {
      response = await get('stock/calculateStockCosts', query: {
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
