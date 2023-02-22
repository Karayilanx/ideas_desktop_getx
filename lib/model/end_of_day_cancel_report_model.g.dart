// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_cancel_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDayCancelModel _$EndOfDayCancelModelFromJson(Map<String, dynamic> json) =>
    EndOfDayCancelModel(
      amount: (json['amount'] as num?)?.toDouble(),
      cancelDate: json['cancelDate'] == null
          ? null
          : DateTime.parse(json['cancelDate'] as String),
      cancelNote: json['cancelNote'] as String?,
      cancelType: json['cancelType'] as String?,
      checkId: json['checkId'] as int?,
      checkMenuItemName: json['checkMenuItemName'] as String?,
      checkName: json['checkName'] as String?,
      orderDate: json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EndOfDayCancelModelToJson(
        EndOfDayCancelModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'checkName': instance.checkName,
      'checkMenuItemName': instance.checkMenuItemName,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'orderDate': instance.orderDate?.toIso8601String(),
      'cancelDate': instance.cancelDate?.toIso8601String(),
      'cancelType': instance.cancelType,
      'cancelNote': instance.cancelNote,
    };
