// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datetime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeModel _$DateTimeModelFromJson(Map<String, dynamic> json) =>
    DateTimeModel(
      value: json['value'] == null
          ? null
          : DateTime.parse(json['value'] as String),
    );

Map<String, dynamic> _$DateTimeModelToJson(DateTimeModel instance) =>
    <String, dynamic>{
      'value': instance.value?.toIso8601String(),
    };
