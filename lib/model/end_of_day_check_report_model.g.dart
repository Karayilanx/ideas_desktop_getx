// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_check_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDayCheckReportModel _$EndOfDayCheckReportModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayCheckReportModel(
      checkId: json['checkId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.parse(json['closeDate'] as String),
      cashAmount: (json['cashAmount'] as num?)?.toDouble(),
      creditCardAmount: (json['creditCardAmount'] as num?)?.toDouble(),
      checkAccountAmount: (json['checkAccountAmount'] as num?)?.toDouble(),
      checkAmount: (json['checkAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      serviceChargeAmount: (json['serviceChargeAmount'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      verification: (json['verification'] as num?)?.toDouble(),
      name: json['name'] as String?,
      isUnpayable: json['isUnpayable'] as bool?,
      endOfDayId: json['endOfDayId'] as int?,
    );

Map<String, dynamic> _$EndOfDayCheckReportModelToJson(
        EndOfDayCheckReportModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'endOfDayId': instance.endOfDayId,
      'createDate': instance.createDate?.toIso8601String(),
      'closeDate': instance.closeDate?.toIso8601String(),
      'cashAmount': instance.cashAmount,
      'creditCardAmount': instance.creditCardAmount,
      'checkAccountAmount': instance.checkAccountAmount,
      'checkAmount': instance.checkAmount,
      'discountAmount': instance.discountAmount,
      'serviceChargeAmount': instance.serviceChargeAmount,
      'amount': instance.amount,
      'verification': instance.verification,
      'name': instance.name,
      'isUnpayable': instance.isUnpayable,
    };

EndOfDayLogModel _$EndOfDayLogModelFromJson(Map<String, dynamic> json) =>
    EndOfDayLogModel(
      checkId: json['checkId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      endOfDayId: json['endOfDayId'] as int?,
      info: json['info'] as String?,
      logType: json['logType'] as String?,
      terminalUserId: json['terminalUserId'] as int?,
      terminalUserName: json['terminalUserName'] as String?,
    );

Map<String, dynamic> _$EndOfDayLogModelToJson(EndOfDayLogModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'endOfDayId': instance.endOfDayId,
      'createDate': instance.createDate?.toIso8601String(),
      'terminalUserId': instance.terminalUserId,
      'terminalUserName': instance.terminalUserName,
      'info': instance.info,
      'logType': instance.logType,
    };
