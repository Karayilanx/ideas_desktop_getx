import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/getir_model.dart';

class GetirService extends BaseGetConnect {
  Future<GetirCheckDetailsModel?> getGetirOrderDetails(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/getGetirOrderDetails', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirCheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> verifyGetirOrder(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/verifyGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> verifyScheduledGetirOrder(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/verifyScheduledGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> prepareGetirOrder(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/prepareGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> handoverGetirOrder(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/handoverGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> deliverGetirOrder(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/deliverGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString()
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<GetirCancelOption>?> getGetirCancelOptions(
      int branchId, String getirId) async {
    Response? response;
    try {
      response = await get('getir/getGetirCancelOptions', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString(),
      });

      return response.body
          .map((data) => GetirCancelOption.fromJson(data))
          .cast<GetirCancelOption>()
          .toList() as List<GetirCancelOption>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirCancelOption?> cancelGetirOrder(int branchId, String getirId,
      String? cancelReasonId, String cancelNote) async {
    Response? response;
    try {
      response = await get('getir/cancelGetirOrder', query: {
        'branchId': branchId.toString(),
        'getirId': getirId.toString(),
        'cancelReasonId': cancelReasonId.toString(),
        'cancelNote': cancelNote.toString(),
      });

      return GetirCancelOption.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> refreshGetir(int branchId) async {
    Response? response;
    try {
      response = await get('getir/refreshGetir', query: {
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> disableCourier(int branchId) async {
    Response? response;
    try {
      response = await get('getir/disableCourier', query: {
        'branchId': branchId.toString(),
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> enableCourier(int branchId) async {
    Response? response;
    try {
      response = await get('getir/enableCourier', query: {
        'branchId': branchId.toString(),
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> closeRestaurant(int branchId) async {
    Response? response;
    try {
      response = await get('getir/closeRestaurant', query: {
        'branchId': branchId.toString(),
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirResultOutput?> openRestaurant(int branchId) async {
    Response? response;
    try {
      response = await get('getir/openRestaurant', query: {
        'branchId': branchId.toString(),
      });

      return GetirResultOutput.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetirRestaurantStatusModel?> getRestaurantStatus(int branchId) async {
    Response? response;
    try {
      response = await get('getir/getRestaurantStatus', query: {
        'branchId': branchId.toString(),
      });

      return GetirRestaurantStatusModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
