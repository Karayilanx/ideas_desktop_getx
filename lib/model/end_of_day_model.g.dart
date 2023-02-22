// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckCountModel _$CheckCountModelFromJson(Map<String, dynamic> json) =>
    CheckCountModel(
      alias: json['alias'] as int?,
      delivery: json['delivery'] as int?,
      fastSell: json['fastSell'] as int?,
      getir: json['getir'] as int?,
      table: json['table'] as int?,
      yemeksepeti: json['yemeksepeti'] as int?,
    );

Map<String, dynamic> _$CheckCountModelToJson(CheckCountModel instance) =>
    <String, dynamic>{
      'yemeksepeti': instance.yemeksepeti,
      'getir': instance.getir,
      'delivery': instance.delivery,
      'fastSell': instance.fastSell,
      'alias': instance.alias,
      'table': instance.table,
    };
