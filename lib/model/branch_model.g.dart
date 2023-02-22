// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkInfoModel _$NetworkInfoModelFromJson(Map<String, dynamic> json) =>
    NetworkInfoModel(
      ipAddress: json['ipAddress'] as String?,
      networkName: json['networkName'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$NetworkInfoModelToJson(NetworkInfoModel instance) =>
    <String, dynamic>{
      'ipAddress': instance.ipAddress,
      'networkName': instance.networkName,
      'type': instance.type,
    };

ServerChangeMsgModel _$ServerChangeMsgModelFromJson(
        Map<String, dynamic> json) =>
    ServerChangeMsgModel(
      msgID: json['msgID'] as int?,
      branchId: json['branchId'] as int?,
      header: json['header'] as String?,
      message: json['message'] as String?,
      msgTypeId: json['msgTypeId'] as int?,
    );

Map<String, dynamic> _$ServerChangeMsgModelToJson(
        ServerChangeMsgModel instance) =>
    <String, dynamic>{
      'msgID': instance.msgID,
      'branchId': instance.branchId,
      'header': instance.header,
      'message': instance.message,
      'msgTypeId': instance.msgTypeId,
    };

CheckServerChangesModel _$CheckServerChangesModelFromJson(
        Map<String, dynamic> json) =>
    CheckServerChangesModel(
      changeCount: json['changeCount'] as int?,
      message: json['message'] == null
          ? null
          : ServerChangeMsgModel.fromJson(
              json['message'] as Map<String, dynamic>),
      unsendEndOfDaysCount: json['unsendEndOfDaysCount'] as int?,
    );

Map<String, dynamic> _$CheckServerChangesModelToJson(
        CheckServerChangesModel instance) =>
    <String, dynamic>{
      'changeCount': instance.changeCount,
      'unsendEndOfDaysCount': instance.unsendEndOfDaysCount,
      'message': instance.message,
    };

TerminalUserModel _$TerminalUserModelFromJson(Map<String, dynamic> json) =>
    TerminalUserModel(
      branchId: json['branchId'] as int?,
      canCancel: json['canCancel'] as bool?,
      canDiscount: json['canDiscount'] as bool?,
      canEndDay: json['canEndDay'] as bool?,
      canGift: json['canGift'] as bool?,
      canMakeCheckPayment: json['canMakeCheckPayment'] as bool?,
      canMarkUnpayable: json['canMarkUnpayable'] as bool?,
      canRestoreCheck: json['canRestoreCheck'] as bool?,
      canSeeActions: json['canSeeActions'] as bool?,
      canSendCheckToCheckAccount: json['canSendCheckToCheckAccount'] as bool?,
      canTransferCheck: json['canTransferCheck'] as bool?,
      isActive: json['isActive'] as bool?,
      maxDiscountPercentage: json['maxDiscountPercentage'] as int?,
      name: json['name'] as String?,
      pin: json['pin'] as String?,
      terminalUserId: json['terminalUserId'] as int?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$TerminalUserModelToJson(TerminalUserModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'terminalUserId': instance.terminalUserId,
      'name': instance.name,
      'pin': instance.pin,
      'isActive': instance.isActive,
      'maxDiscountPercentage': instance.maxDiscountPercentage,
      'canGift': instance.canGift,
      'canMarkUnpayable': instance.canMarkUnpayable,
      'canDiscount': instance.canDiscount,
      'canTransferCheck': instance.canTransferCheck,
      'canRestoreCheck': instance.canRestoreCheck,
      'canSendCheckToCheckAccount': instance.canSendCheckToCheckAccount,
      'canMakeCheckPayment': instance.canMakeCheckPayment,
      'canCancel': instance.canCancel,
      'canEndDay': instance.canEndDay,
      'canSeeActions': instance.canSeeActions,
      'isAdmin': instance.isAdmin,
    };

UpdateTerminalUsersModel _$UpdateTerminalUsersModelFromJson(
        Map<String, dynamic> json) =>
    UpdateTerminalUsersModel(
      branchId: json['branchId'] as int?,
      terminalUsers: (json['terminalUsers'] as List<dynamic>?)
          ?.map((e) => TerminalUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateTerminalUsersModelToJson(
        UpdateTerminalUsersModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'terminalUsers': instance.terminalUsers,
    };
