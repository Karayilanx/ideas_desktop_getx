import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/getir_model.dart';
import '../../model/yemeksepeti_model.dart';

class YemeksepetiService extends BaseGetConnect {
  Future<YemeksepetiCheckDetailsModel?> getYemeksepetiOrderDetails(
      int branchId, String yemeksepetiId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/getYemeksepetiOrderDetails', query: {
        'branchId': branchId.toString(),
        'yemeksepetiId': yemeksepetiId.toString(),
      });

      return YemeksepetiCheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> refreshYemeksepeti(int branchId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/refreshYemeksepeti', query: {
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> deleteYemeksepetiOrder(String yemeksepetiId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/deleteYemeksepetiOrder', query: {
        'yemeksepetiId': yemeksepetiId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateOrder(int branchId, String yemeksepetiId,
      int orderState, int terminalUserId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/updateOrder', query: {
        'orderState': orderState.toString(),
        'branchId': branchId.toString(),
        'yemeksepetiId': yemeksepetiId.toString(),
        'terminalUserId': terminalUserId.toString()
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateValeOrder(int branchId, String yemeksepetiId,
      int orderState, int terminalUserId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/updateValeOrder', query: {
        'orderState': orderState.toString(),
        'branchId': branchId.toString(),
        'yemeksepetiId': yemeksepetiId.toString(),
        'terminalUserId': terminalUserId.toString()
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<YemeksepetiRejectReason>?> getYemeksepetiRejectReasons(
      int branchId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/getYemeksepetiRejectReasons', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => YemeksepetiRejectReason.fromJson(data))
          .cast<YemeksepetiRejectReason>()
          .toList() as List<YemeksepetiRejectReason>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> rejectYemeksepetiOrder(int branchId,
      String yemeksepetiId, String reason, String rejectReasonId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/rejectYemeksepetiOrder', query: {
        'reason': reason.toString(),
        'branchId': branchId.toString(),
        'yemeksepetiId': yemeksepetiId.toString(),
        'rejectReasonId': rejectReasonId.toString()
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> rejectYemeksepetiValeOrder(int branchId,
      String yemeksepetiId, String reason, String rejectReasonId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/rejectYemeksepetiValeOrder', query: {
        'reason': reason.toString(),
        'branchId': branchId.toString(),
        'yemeksepetiId': yemeksepetiId.toString(),
        'rejectReasonId': rejectReasonId.toString()
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<YemeksepetiRestaurantModel?> getRestaurantList(int branchId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/getRestaurantList', query: {
        'branchId': branchId.toString(),
      });

      return YemeksepetiRestaurantModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> isRestaurantOpen(int branchId) async {
    Response? response;
    try {
      response = await get('yemeksepeti/isRestaurantOpen', query: {
        'branchId': branchId.toString(),
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateRestaurantState(
      int branchId, int restaurantState) async {
    Response? response;
    try {
      response = await get('yemeksepeti/updateRestaurantState', query: {
        'branchId': branchId.toString(),
        'restaurantState': restaurantState
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
