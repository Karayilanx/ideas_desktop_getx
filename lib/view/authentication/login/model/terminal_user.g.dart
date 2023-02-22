// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalUser _$TerminalUserFromJson(Map<String, dynamic> json) => TerminalUser(
      branchName: json['branchName'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      pass: json['pass'] as String?,
      terminalUserId: json['terminalUserId'] as int?,
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
      serverBranchId: json['serverBranchId'] as int?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$TerminalUserToJson(TerminalUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'pass': instance.pass,
      'terminalUserId': instance.terminalUserId,
      'branchId': instance.branchId,
      'name': instance.name,
      'branchName': instance.branchName,
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
      'serverBranchId': instance.serverBranchId,
      'isAdmin': instance.isAdmin,
    };
