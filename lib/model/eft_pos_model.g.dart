// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eft_pos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EftPosModel _$EftPosModelFromJson(Map<String, dynamic> json) => EftPosModel(
      eftPosId: json['eftPosId'] as int?,
      eftPosName: json['eftPosName'] as String?,
      ipAddress: json['ipAddress'] as String?,
      fiscalId: json['fiscalId'] as String?,
      isActive: json['isActive'] as bool?,
      checkAccountIds: (json['checkAccountIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      checkAccountName: json['checkAccountName'] as String?,
      branchId: json['branchId'] as int?,
      acquirerId: json['acquirerId'] as String?,
    );

Map<String, dynamic> _$EftPosModelToJson(EftPosModel instance) =>
    <String, dynamic>{
      'eftPosId': instance.eftPosId,
      'eftPosName': instance.eftPosName,
      'ipAddress': instance.ipAddress,
      'fiscalId': instance.fiscalId,
      'isActive': instance.isActive,
      'checkAccountIds': instance.checkAccountIds,
      'checkAccountName': instance.checkAccountName,
      'branchId': instance.branchId,
      'acquirerId': instance.acquirerId,
    };

OkcDeptModel _$OkcDeptModelFromJson(Map<String, dynamic> json) => OkcDeptModel(
      okcDeptId: json['okcDeptId'] as int?,
      deptId: json['deptId'] as int?,
      deptName: json['deptName'] as String?,
      kdv: json['kdv'] as int?,
      isActive: json['isActive'] as bool?,
      eftPosId: json['eftPosId'] as int?,
    );

Map<String, dynamic> _$OkcDeptModelToJson(OkcDeptModel instance) =>
    <String, dynamic>{
      'okcDeptId': instance.okcDeptId,
      'deptId': instance.deptId,
      'deptName': instance.deptName,
      'kdv': instance.kdv,
      'isActive': instance.isActive,
      'eftPosId': instance.eftPosId,
    };

DeptSellInput _$DeptSellInputFromJson(Map<String, dynamic> json) =>
    DeptSellInput(
      json['branchId'] as int?,
      json['eftPosId'] as int?,
      json['deptId'] as int?,
      json['deptName'] as String?,
      (json['amount'] as num?)?.toDouble(),
      json['paymentType'] as int?,
    );

Map<String, dynamic> _$DeptSellInputToJson(DeptSellInput instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'eftPosId': instance.eftPosId,
      'deptId': instance.deptId,
      'deptName': instance.deptName,
      'amount': instance.amount,
      'paymentType': instance.paymentType,
    };
