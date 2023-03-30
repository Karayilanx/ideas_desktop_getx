import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/datetime_model.dart';
import 'package:ideas_desktop_getx/model/integer_model.dart';
import 'package:ideas_desktop_getx/model/stock_model.dart';
import 'package:ideas_desktop_getx/service/base_get_connect.dart';

import '../../model/check_model.dart';
import '../../model/end_of_day_cancel_report_model.dart';
import '../../model/end_of_day_check_account_report_model.dart';
import '../../model/end_of_day_check_report_model.dart';
import '../../model/end_of_day_model.dart';
import '../../model/end_of_day_sales_report.dart';
import '../../model/end_of_day_summary_model.dart';
import '../../model/end_of_day_unpayable_report_model.dart';

class EndOfDayService extends BaseGetConnect {
  Future<List<UncalculatedEndOfDayModel>?> getNotCalculatedEndOfDays(
      int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getNotCalculatedEndOfDays', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => UncalculatedEndOfDayModel.fromJson(data))
          .cast<UncalculatedEndOfDayModel>()
          .toList() as List<UncalculatedEndOfDayModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDaySummaryReportModel?> getEndOfDaySummaryReport(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDaySummaryReport', query: {
        'branchId': branchId.toString(),
      });

      return EndOfDaySummaryReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCheckReportModel>?> getEndOfDayCheckReport(
      int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayCheckReport', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => EndOfDayCheckReportModel.fromJson(data))
          .cast<EndOfDayCheckReportModel>()
          .toList() as List<EndOfDayCheckReportModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayLogModel>?> getEndOfDayLogReport(int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayLogReport', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => EndOfDayLogModel.fromJson(data))
          .cast<EndOfDayLogModel>()
          .toList() as List<EndOfDayLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDaySaleReportModel>?> getEndOfDaySaleReport(
      int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDaySaleReport', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => EndOfDaySaleReportModel.fromJson(data))
          .cast<EndOfDaySaleReportModel>()
          .toList() as List<EndOfDaySaleReportModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDayUnpayableReportModel?> getEndOfDayUnpayableReport(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayUnpayableReport', query: {
        'branchId': branchId.toString(),
      });

      return EndOfDayUnpayableReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDayCheckAccountReportModel?> getEndOfDayCheckAccountReport(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayCheckAccountReport', query: {
        'branchId': branchId.toString(),
      });

      return EndOfDayCheckAccountReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCancelModel>?> getEndOfDayCancelReport(
      int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayCancelReport', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => EndOfDayCancelModel.fromJson(data))
          .cast<EndOfDayCancelModel>()
          .toList() as List<EndOfDayCancelModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCancelModel>?> getEndOfDayGiftReport(int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayGiftReport', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => EndOfDayCancelModel.fromJson(data))
          .cast<EndOfDayCancelModel>()
          .toList() as List<EndOfDayCancelModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckDetailsModel?> getFirstCheckOfTheDay(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/getFirstCheckOfTheDay', query: {
        'branchId': branchId.toString(),
      });

      return CheckDetailsModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> tryServerConnection(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/tryServerConnection', query: {
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<DateTimeModel>?> getEndOfDayDates(int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayDates', query: {
        'branchId': branchId.toString(),
      });

      return response.body
          .map((data) => DateTimeModel.fromJson(data))
          .cast<DateTimeModel>()
          .toList() as List<DateTimeModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> endDay(
    int branchId,
    DateTime endOfDayDate,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/endDay', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CheckCountModel?> getOpenCheckCounts(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/getOpenCheckCounts', query: {
        'branchId': branchId.toString(),
      });

      return CheckCountModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> sendEndOfDaysToServer(
    int branchId,
  ) async {
    Response? response;
    try {
      response = await get('endOfDay/sendEndOfDaysToServer', query: {
        'branchId': branchId.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printEndOfDaySummaryReport(
      int branchId, DateTime? endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/printEndOfDaySummaryReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate?.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printEndOfDayCheckReport(
      int branchId, DateTime? endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/printEndOfDayCheckReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate?.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printEndOfDaySaleReport(
      int branchId, DateTime? endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/printEndOfDaySaleReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate?.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> printEndOfDayCategoryReport(
      int branchId, DateTime? endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/printEndOfDayCategoryReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate?.toString(),
      });

      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDaySummaryReportModel?> getEndOfDayPastSummaryReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastSummaryReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString(),
      });

      return EndOfDaySummaryReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCheckReportModel>?> getEndOfDayPastCheckReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastCheckReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => DateTimeModel.fromJson(data))
          .cast<DateTimeModel>()
          .toList() as List<EndOfDayCheckReportModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayLogModel>?> getEndOfDayPastLogReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastLogReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => EndOfDayLogModel.fromJson(data))
          .cast<EndOfDayLogModel>()
          .toList() as List<EndOfDayLogModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDaySaleReportModel>?> getEndOfDayPastSaleReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastSaleReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => EndOfDaySaleReportModel.fromJson(data))
          .cast<EndOfDaySaleReportModel>()
          .toList() as List<EndOfDaySaleReportModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDayUnpayableReportModel?> getEndOfDayPastUnpayableReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastUnpayableReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return EndOfDayUnpayableReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<EndOfDayCheckAccountReportModel?> getEndOfDayPastCheckAccountReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastCheckAccountReport',
          query: {
            'branchId': branchId.toString(),
            'endOfDayDate': endOfDayDate.toString()
          });

      return EndOfDayCheckAccountReportModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCancelModel>?> getEndOfDayPastCancelReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastCancelReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => EndOfDayCancelModel.fromJson(data))
          .cast<EndOfDayCancelModel>()
          .toList() as List<EndOfDayCancelModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayCancelModel>?> getEndOfDayPastGiftReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastGiftReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => EndOfDayCancelModel.fromJson(data))
          .cast<EndOfDayCancelModel>()
          .toList() as List<EndOfDayCancelModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayHourlySaleModel>?> getEndOfDayHourSaleReport(
      int branchId) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayHourSaleReport',
          query: {'branchId': branchId.toString()});

      return response.body
          .map((data) => EndOfDayHourlySaleModel.fromJson(data))
          .cast<EndOfDayHourlySaleModel>()
          .toList() as List<EndOfDayHourlySaleModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<EndOfDayHourlySaleModel>?> getEndOfDayPastHourSaleReport(
      int branchId, DateTime endOfDayDate) async {
    Response? response;
    try {
      response = await get('endOfDay/getEndOfDayPastHourSaleReport', query: {
        'branchId': branchId.toString(),
        'endOfDayDate': endOfDayDate.toString()
      });

      return response.body
          .map((data) => EndOfDayHourlySaleModel.fromJson(data))
          .cast<EndOfDayHourlySaleModel>()
          .toList() as List<EndOfDayHourlySaleModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}
