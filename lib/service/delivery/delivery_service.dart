import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/delivery_model.dart';

class DeliveryService extends BaseGetConnect {
  Future<List<DeliveryCustomerTableRowModel>?> getDeliveryCustomersForTable(
      int brandId) async {
    Response? response;
    try {
      response = await get('delivery/getDeliveryCustomersForTable', query: {
        'brandId': brandId.toString(),
      });

      return response.body
          .map((data) => DeliveryCustomerTableRowModel.fromJson(data))
          .cast<DeliveryCustomerTableRowModel>()
          .toList() as List<DeliveryCustomerTableRowModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<DeliveryCustomerModel?> createDeliveryCustomer(
      DeliveryCustomerModel input) async {
    Response? response;
    try {
      response = await post(
        'delivery/createDeliveryCustomer',
        input.toJson(),
      );

      return DeliveryCustomerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<DeliveryCustomerModel>?> getDeliveryCustomers(int brandId) async {
    Response? response;
    try {
      response = await get('delivery/getDeliveryCustomers', query: {
        'brandId': brandId.toString(),
      });

      return response.body
          .map((data) => DeliveryCustomerModel.fromJson(data))
          .cast<DeliveryCustomerModel>()
          .toList() as List<DeliveryCustomerModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<DeliveryListItem>?> getTodaysDeliveryOrders(int branchId) async {
    Response? response;
    try {
      response = await get('delivery/getTodaysDeliveryOrders', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => DeliveryListItem.fromJson(data))
          .cast<DeliveryListItem>()
          .toList() as List<DeliveryListItem>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<DeliveryCustomerModel?> getDeliveryCustomerFromPhoneNumber(
      String phoneNumber) async {
    Response? response;
    try {
      response = await get('delivery/getDeliveryCustomerFromPhoneNumber',
          query: {'phoneNumber': phoneNumber.toString()});

      return DeliveryCustomerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<DeliveryCustomerModel?> getDeliveryCustomerFromId(
      int deliveryCustomerId, int? deliveryCustomerAddressId) async {
    Response? response;
    try {
      response = await get('delivery/getDeliveryCustomerFromId', query: {
        'deliveryCustomerId': deliveryCustomerId.toString(),
        'deliveryCustomerAddressId': deliveryCustomerAddressId.toString()
      });

      return DeliveryCustomerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CourierModel>?> getCouriers(int branchId) async {
    Response? response;
    try {
      response = await get('delivery/getCouriers', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => CourierModel.fromJson(data))
          .cast<CourierModel>()
          .toList() as List<CourierModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> createCourier(CourierModel input) async {
    Response? response;
    try {
      response = await post(
        'delivery/createCourier',
        input.toJson(),
      );

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> deleteCourier(int courierId) async {
    Response? response;
    try {
      response = await get('delivery/deleteCourier', query: {
        'courierId': courierId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> setCourier(int checkId, int courierId) async {
    Response? response;
    try {
      response = await get('delivery/setCourier', query: {
        'courierId': courierId.toString(),
        'checkId': checkId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
