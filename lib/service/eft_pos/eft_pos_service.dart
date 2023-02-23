import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/eft_pos_model.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

class EftPosService extends BaseGetConnect {
  Future<List<EftPosModel>?> getEftPoss(int branchId) async {
    Response? response;
    try {
      response = await get('eftPos/getEftPoss', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => EftPosModel.fromJson(data))
          .cast<EftPosModel>()
          .toList() as List<EftPosModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> removeEftPos(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/removeEftPos', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> saveEftPoss(List<EftPosModel> input) async {
    Response? response;
    try {
      response = await post(
          'eftPos/saveEftPoss', input.map((e) => e.toJson()).toList());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> connectEftPos(int branchId, int? eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/connectEftPos', query: {
        'eftPosId': eftPosId.toString(),
        'branchId': branchId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> startReceipt(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/startReceipt', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> voidReceipt(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/voidReceipt', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> deptSellCheck(
      int eftPosId, int checkId, int branchId, int paymentType) async {
    Response? response;
    try {
      response = await get('eftPos/deptSellCheck', query: {
        'eftPosId': eftPosId.toString(),
        'checkId': checkId.toString(),
        'branchId': branchId.toString(),
        'paymentType': paymentType.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> closeReceipt(
      int eftPosId, int? checkId, int paymentType, double amount) async {
    Response? response;
    try {
      response = await get('eftPos/closeReceipt', query: {
        'eftPosId': eftPosId.toString(),
        'checkId': checkId.toString(),
        'paymentType': paymentType.toString(),
        'amount': amount.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<OkcDeptModel>?> getDepartments(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/getDepartments', query: {
        'eftPosId': eftPosId.toString(),
      });
      return response.body
          .map((data) => OkcDeptModel.fromJson(data))
          .cast<OkcDeptModel>()
          .toList() as List<OkcDeptModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> deptSell(List<DeptSellInput> input) async {
    Response? response;
    try {
      response =
          await post('eftPos/deptSell', input.map((e) => e.toJson()).toList());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> xReport(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/xReport', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> ekuReport(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/ekuReport', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> zReport(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/zReport', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> voidEftPayment(int eftPosId) async {
    Response? response;
    try {
      response = await get('eftPos/voidEftPayment', query: {
        'eftPosId': eftPosId.toString(),
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
