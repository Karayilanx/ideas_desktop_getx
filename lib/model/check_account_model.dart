import 'package:json_annotation/json_annotation.dart';

import 'check_model.dart';

part 'check_account_model.g.dart';

@JsonSerializable()
class CreateCheckAccountInput {
  String? name;
  String? phoneNumber;
  String? checkAccountAddress;
  String? taxOffice;
  String? taxNo;
  int? branchId;
  int? checkAccountId;
  int? checkAccountTypeId;
  double? discountPercentage;
  CreateCheckAccountInput({
    this.branchId,
    this.checkAccountAddress,
    this.name,
    this.phoneNumber,
    this.taxNo,
    this.taxOffice,
    this.checkAccountTypeId,
    this.checkAccountId,
    this.discountPercentage,
  });

  factory CreateCheckAccountInput.fromJson(Map<String, dynamic> json) {
    return _$CreateCheckAccountInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CreateCheckAccountInputToJson(this);
  }
}

@JsonSerializable()
class CheckAccountListItem {
  int? checkAccountId;
  String? name;
  double? balance;
  int? checkAccountTypeId;
  int? eftPosId;
  CheckAccountListItem({
    this.checkAccountId,
    this.name,
    this.balance,
    this.checkAccountTypeId,
    this.eftPosId,
  });

  factory CheckAccountListItem.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountListItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountListItemToJson(this);
  }
}

@JsonSerializable()
class TransferCheckToCheckAccountInput {
  int? checkId;
  int? checkAccountId;
  bool? transferAll;
  List<CheckMenuItemModel?>? menuItems;
  int branchId;
  int terminalUserId;
  TransferCheckToCheckAccountInput({
    this.checkId,
    this.checkAccountId,
    this.transferAll,
    this.menuItems,
    required this.branchId,
    required this.terminalUserId,
  });

  factory TransferCheckToCheckAccountInput.fromJson(Map<String, dynamic> json) {
    return _$TransferCheckToCheckAccountInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TransferCheckToCheckAccountInputToJson(this);
  }
}

@JsonSerializable()
class CheckAccountTransactionListItem {
  int? checkAccountTransactionId;
  DateTime? createDate;
  double? amount;
  int? checkId;
  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: false)
  bool expaned;
  CheckDetailsModel? checkDetail;
  int? checkAccountTransactionTypeId;
  String? info;
  int? endOfDayId;
  CheckAccountTransactionListItem({
    this.checkAccountTransactionId,
    this.createDate,
    this.amount,
    this.checkId,
    this.expaned = false,
    this.checkDetail,
    this.checkAccountTransactionTypeId,
    this.info,
    this.endOfDayId,
  });

  factory CheckAccountTransactionListItem.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountTransactionListItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountTransactionListItemToJson(this);
  }
}

@JsonSerializable()
class GetCheckAccountTransactionsOutput {
  int? checkAccountId;
  String? name;
  double? balance;
  List<CheckAccountTransactionListItem>? checkAccountTransactions;
  GetCheckAccountTransactionsOutput({
    this.checkAccountId,
    this.name,
    this.balance,
    this.checkAccountTransactions,
  });

  factory GetCheckAccountTransactionsOutput.fromJson(
      Map<String, dynamic> json) {
    return _$GetCheckAccountTransactionsOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetCheckAccountTransactionsOutputToJson(this);
  }
}

@JsonSerializable()
class CheckAccountSummaryModel {
  String? name;
  double? balance;
  double? discountAmount;
  double? totalPaymentAmount;
  double? totalDebtAmount;
  CheckAccountSummaryModel({
    this.name,
    this.balance,
    this.discountAmount,
    this.totalPaymentAmount,
    this.totalDebtAmount,
  });

  factory CheckAccountSummaryModel.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountSummaryModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountSummaryModelToJson(this);
  }
}

@JsonSerializable()
class CheckAccountTransactionModel {
  int? checkAccountId;
  double? amount;
  int? checkAccountTransactionTypeId;
  int terminalUserId;
  CheckAccountTransactionModel({
    this.checkAccountId,
    this.amount,
    this.checkAccountTransactionTypeId,
    required this.terminalUserId,
  });

  factory CheckAccountTransactionModel.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountTransactionModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountTransactionModelToJson(this);
  }
}

@JsonSerializable()
class GetCheckAccountsInput {
  int? branchId;
  List<int>? checkAccountTypeIds;
  GetCheckAccountsInput({
    this.branchId,
    this.checkAccountTypeIds,
  });

  factory GetCheckAccountsInput.fromJson(Map<String, dynamic> json) {
    return _$GetCheckAccountsInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetCheckAccountsInputToJson(this);
  }
}
