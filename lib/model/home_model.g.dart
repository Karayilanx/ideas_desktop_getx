// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeGroupWithDetails _$HomeGroupWithDetailsFromJson(
        Map<String, dynamic> json) =>
    HomeGroupWithDetails(
      name: json['name'] as String?,
      tableGroupId: json['tableGroupId'] as int?,
      tables: (json['tables'] as List<dynamic>?)
          ?.map((e) => TableWithDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasFastSellCheck: json['hasFastSellCheck'] as bool?,
    );

Map<String, dynamic> _$HomeGroupWithDetailsToJson(
        HomeGroupWithDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tableGroupId': instance.tableGroupId,
      'tables': instance.tables,
      'hasFastSellCheck': instance.hasFastSellCheck,
    };
