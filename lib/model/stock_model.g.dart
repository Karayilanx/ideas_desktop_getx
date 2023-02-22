// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UncalculatedEndOfDayModel _$UncalculatedEndOfDayModelFromJson(
        Map<String, dynamic> json) =>
    UncalculatedEndOfDayModel(
      branchId: json['branchId'] as int?,
      endOfDayId: json['endOfDayId'] as int?,
      endOfDayDate: json['endOfDayDate'] == null
          ? null
          : DateTime.parse(json['endOfDayDate'] as String),
    );

Map<String, dynamic> _$UncalculatedEndOfDayModelToJson(
        UncalculatedEndOfDayModel instance) =>
    <String, dynamic>{
      'endOfDayDate': instance.endOfDayDate?.toIso8601String(),
      'endOfDayId': instance.endOfDayId,
      'branchId': instance.branchId,
    };
