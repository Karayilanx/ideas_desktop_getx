import 'package:json_annotation/json_annotation.dart';
part 'end_of_day_check_report_model.g.dart';

@JsonSerializable()
class EndOfDayCheckReportModel {
  int? checkId;
  int? endOfDayId;
  DateTime? createDate;
  DateTime? closeDate;
  double? cashAmount;
  double? creditCardAmount;
  double? checkAccountAmount;
  double? checkAmount;
  double? discountAmount;
  double? serviceChargeAmount;
  double? amount;
  double? verification;
  String? name;
  bool? isUnpayable;
  EndOfDayCheckReportModel({
    this.checkId,
    this.createDate,
    this.closeDate,
    this.cashAmount,
    this.creditCardAmount,
    this.checkAccountAmount,
    this.checkAmount,
    this.discountAmount,
    this.serviceChargeAmount,
    this.amount,
    this.verification,
    this.name,
    this.isUnpayable,
    this.endOfDayId,
  });

  factory EndOfDayCheckReportModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayCheckReportModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$EndOfDayCheckReportModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayLogModel {
  int? checkId;
  int? endOfDayId;
  DateTime? createDate;
  int? terminalUserId;
  String? terminalUserName;
  String? info;
  String? logType;
  EndOfDayLogModel({
    this.checkId,
    this.createDate,
    this.endOfDayId,
    this.info,
    this.logType,
    this.terminalUserId,
    this.terminalUserName,
  });

  factory EndOfDayLogModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayLogModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$EndOfDayLogModelToJson(this);
  }
}
