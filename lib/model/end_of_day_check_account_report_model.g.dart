// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_check_account_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDayCheckAccountReportModel _$EndOfDayCheckAccountReportModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayCheckAccountReportModel(
      totalLoan: (json['totalLoan'] as num?)?.toDouble(),
      totalReceiving: (json['totalReceiving'] as num?)?.toDouble(),
      checks: (json['checks'] as List<dynamic>?)
          ?.map((e) => EndOfDayCheckAccountCheckModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      receivings: (json['receivings'] as List<dynamic>?)
          ?.map((e) => EndOfDayCheckAccountReceivingModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EndOfDayCheckAccountReportModelToJson(
        EndOfDayCheckAccountReportModel instance) =>
    <String, dynamic>{
      'totalLoan': instance.totalLoan,
      'totalReceiving': instance.totalReceiving,
      'checks': instance.checks,
      'receivings': instance.receivings,
    };

EndOfDayCheckAccountReceivingModel _$EndOfDayCheckAccountReceivingModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayCheckAccountReceivingModel(
      name: json['name'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EndOfDayCheckAccountReceivingModelToJson(
        EndOfDayCheckAccountReceivingModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createDate': instance.createDate?.toIso8601String(),
      'type': instance.type,
      'amount': instance.amount,
    };

EndOfDayCheckAccountCheckModel _$EndOfDayCheckAccountCheckModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayCheckAccountCheckModel(
      checkId: json['checkId'] as int?,
      cashAmount: (json['cashAmount'] as num?)?.toDouble(),
      creditCardAmount: (json['creditCardAmount'] as num?)?.toDouble(),
      checkAccountAmount: (json['checkAccountAmount'] as num?)?.toDouble(),
      checkAmount: (json['checkAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EndOfDayCheckAccountCheckModelToJson(
        EndOfDayCheckAccountCheckModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'cashAmount': instance.cashAmount,
      'creditCardAmount': instance.creditCardAmount,
      'checkAccountAmount': instance.checkAccountAmount,
      'checkAmount': instance.checkAmount,
      'discountAmount': instance.discountAmount,
      'name': instance.name,
    };
