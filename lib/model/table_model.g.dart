// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableWithDetails _$TableWithDetailsFromJson(Map<String, dynamic> json) =>
    TableWithDetails(
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      checkDetail: json['checkDetail'] == null
          ? null
          : CheckDetailsModel.fromJson(
              json['checkDetail'] as Map<String, dynamic>),
      checkId: json['checkId'] as int? ?? -1,
      status: json['status'] as int?,
      tableId: json['tableId'] as int?,
      terminalUserName: json['terminalUserName'] as String?,
      minute: json['minute'] as int?,
      disablePersonCount: json['disablePersonCount'] as bool?,
    );

Map<String, dynamic> _$TableWithDetailsToJson(TableWithDetails instance) =>
    <String, dynamic>{
      'tableId': instance.tableId,
      'name': instance.name,
      'amount': instance.amount,
      'terminalUserName': instance.terminalUserName,
      'status': instance.status,
      'checkId': instance.checkId,
      'minute': instance.minute,
      'disablePersonCount': instance.disablePersonCount,
      'checkDetail': instance.checkDetail,
    };
