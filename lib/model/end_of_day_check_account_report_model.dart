import 'package:json_annotation/json_annotation.dart';

part 'end_of_day_check_account_report_model.g.dart';

@JsonSerializable()
class EndOfDayCheckAccountReportModel {
  double? totalLoan;
  double? totalReceiving;
  List<EndOfDayCheckAccountCheckModel>? checks;
  List<EndOfDayCheckAccountReceivingModel>? receivings;
  EndOfDayCheckAccountReportModel({
    this.totalLoan,
    this.totalReceiving,
    this.checks,
    this.receivings,
  });

  factory EndOfDayCheckAccountReportModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayCheckAccountReportModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayCheckAccountReportModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayCheckAccountReceivingModel {
  String? name;
  DateTime? createDate;
  String? type;
  double? amount;
  EndOfDayCheckAccountReceivingModel({
    this.name,
    this.createDate,
    this.type,
    this.amount,
  });

  factory EndOfDayCheckAccountReceivingModel.fromJson(
      Map<String, dynamic> json) {
    return _$EndOfDayCheckAccountReceivingModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayCheckAccountReceivingModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayCheckAccountCheckModel {
  int? checkId;
  double? cashAmount;
  double? creditCardAmount;
  double? checkAccountAmount;
  double? checkAmount;
  double? discountAmount;
  String? name;
  EndOfDayCheckAccountCheckModel({
    this.checkId,
    this.cashAmount,
    this.creditCardAmount,
    this.checkAccountAmount,
    this.checkAmount,
    this.discountAmount,
    this.name,
  });

  factory EndOfDayCheckAccountCheckModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayCheckAccountCheckModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayCheckAccountCheckModelToJson(this);
  }
}
