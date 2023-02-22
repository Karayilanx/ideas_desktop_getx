// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCheckAccountInput _$CreateCheckAccountInputFromJson(
        Map<String, dynamic> json) =>
    CreateCheckAccountInput(
      branchId: json['branchId'] as int?,
      checkAccountAddress: json['checkAccountAddress'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      taxNo: json['taxNo'] as String?,
      taxOffice: json['taxOffice'] as String?,
      checkAccountTypeId: json['checkAccountTypeId'] as int?,
      checkAccountId: json['checkAccountId'] as int?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreateCheckAccountInputToJson(
        CreateCheckAccountInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'checkAccountAddress': instance.checkAccountAddress,
      'taxOffice': instance.taxOffice,
      'taxNo': instance.taxNo,
      'branchId': instance.branchId,
      'checkAccountId': instance.checkAccountId,
      'checkAccountTypeId': instance.checkAccountTypeId,
      'discountPercentage': instance.discountPercentage,
    };

CheckAccountListItem _$CheckAccountListItemFromJson(
        Map<String, dynamic> json) =>
    CheckAccountListItem(
      checkAccountId: json['checkAccountId'] as int?,
      name: json['name'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      checkAccountTypeId: json['checkAccountTypeId'] as int?,
      eftPosId: json['eftPosId'] as int?,
    );

Map<String, dynamic> _$CheckAccountListItemToJson(
        CheckAccountListItem instance) =>
    <String, dynamic>{
      'checkAccountId': instance.checkAccountId,
      'name': instance.name,
      'balance': instance.balance,
      'checkAccountTypeId': instance.checkAccountTypeId,
      'eftPosId': instance.eftPosId,
    };

TransferCheckToCheckAccountInput _$TransferCheckToCheckAccountInputFromJson(
        Map<String, dynamic> json) =>
    TransferCheckToCheckAccountInput(
      checkId: json['checkId'] as int?,
      checkAccountId: json['checkAccountId'] as int?,
      transferAll: json['transferAll'] as bool?,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchId: json['branchId'] as int,
      terminalUserId: json['terminalUserId'] as int,
    );

Map<String, dynamic> _$TransferCheckToCheckAccountInputToJson(
        TransferCheckToCheckAccountInput instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'checkAccountId': instance.checkAccountId,
      'transferAll': instance.transferAll,
      'menuItems': instance.menuItems,
      'branchId': instance.branchId,
      'terminalUserId': instance.terminalUserId,
    };

CheckAccountTransactionListItem _$CheckAccountTransactionListItemFromJson(
        Map<String, dynamic> json) =>
    CheckAccountTransactionListItem(
      checkAccountTransactionId: json['checkAccountTransactionId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      amount: (json['amount'] as num?)?.toDouble(),
      checkId: json['checkId'] as int?,
      checkDetail: json['checkDetail'] == null
          ? null
          : CheckDetailsModel.fromJson(
              json['checkDetail'] as Map<String, dynamic>),
      checkAccountTransactionTypeId:
          json['checkAccountTransactionTypeId'] as int?,
      info: json['info'] as String?,
      endOfDayId: json['endOfDayId'] as int?,
    );

Map<String, dynamic> _$CheckAccountTransactionListItemToJson(
        CheckAccountTransactionListItem instance) =>
    <String, dynamic>{
      'checkAccountTransactionId': instance.checkAccountTransactionId,
      'createDate': instance.createDate?.toIso8601String(),
      'amount': instance.amount,
      'checkId': instance.checkId,
      'checkDetail': instance.checkDetail,
      'checkAccountTransactionTypeId': instance.checkAccountTransactionTypeId,
      'info': instance.info,
      'endOfDayId': instance.endOfDayId,
    };

GetCheckAccountTransactionsOutput _$GetCheckAccountTransactionsOutputFromJson(
        Map<String, dynamic> json) =>
    GetCheckAccountTransactionsOutput(
      checkAccountId: json['checkAccountId'] as int?,
      name: json['name'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      checkAccountTransactions:
          (json['checkAccountTransactions'] as List<dynamic>?)
              ?.map((e) => CheckAccountTransactionListItem.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetCheckAccountTransactionsOutputToJson(
        GetCheckAccountTransactionsOutput instance) =>
    <String, dynamic>{
      'checkAccountId': instance.checkAccountId,
      'name': instance.name,
      'balance': instance.balance,
      'checkAccountTransactions': instance.checkAccountTransactions,
    };

CheckAccountSummaryModel _$CheckAccountSummaryModelFromJson(
        Map<String, dynamic> json) =>
    CheckAccountSummaryModel(
      name: json['name'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      totalPaymentAmount: (json['totalPaymentAmount'] as num?)?.toDouble(),
      totalDebtAmount: (json['totalDebtAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CheckAccountSummaryModelToJson(
        CheckAccountSummaryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'balance': instance.balance,
      'discountAmount': instance.discountAmount,
      'totalPaymentAmount': instance.totalPaymentAmount,
      'totalDebtAmount': instance.totalDebtAmount,
    };

CheckAccountTransactionModel _$CheckAccountTransactionModelFromJson(
        Map<String, dynamic> json) =>
    CheckAccountTransactionModel(
      checkAccountId: json['checkAccountId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      checkAccountTransactionTypeId:
          json['checkAccountTransactionTypeId'] as int?,
      terminalUserId: json['terminalUserId'] as int,
    );

Map<String, dynamic> _$CheckAccountTransactionModelToJson(
        CheckAccountTransactionModel instance) =>
    <String, dynamic>{
      'checkAccountId': instance.checkAccountId,
      'amount': instance.amount,
      'checkAccountTransactionTypeId': instance.checkAccountTransactionTypeId,
      'terminalUserId': instance.terminalUserId,
    };

GetCheckAccountsInput _$GetCheckAccountsInputFromJson(
        Map<String, dynamic> json) =>
    GetCheckAccountsInput(
      branchId: json['branchId'] as int?,
      checkAccountTypeIds: (json['checkAccountTypeIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$GetCheckAccountsInputToJson(
        GetCheckAccountsInput instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'checkAccountTypeIds': instance.checkAccountTypeIds,
    };
