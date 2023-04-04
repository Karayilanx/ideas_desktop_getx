import 'package:json_annotation/json_annotation.dart';

part 'terminal_user.g.dart';

@JsonSerializable()
class TerminalUser {
  String? email;
  String? pass;
  int? terminalUserId;
  int? branchId;
  String? name;
  String? branchName;
  bool? canGift;
  bool? canMarkUnpayable;
  bool? canDiscount;
  bool? canTransferCheck;
  bool? canRestoreCheck;
  bool? canSendCheckToCheckAccount;
  bool? canMakeCheckPayment;
  bool? canCancel;
  bool? canEndDay;
  bool? canSeeActions;
  int? serverBranchId;
  bool? isAdmin;

  TerminalUser({
    this.branchName,
    this.email,
    this.name,
    this.pass,
    this.terminalUserId,
    this.branchId,
    this.canCancel,
    this.canDiscount,
    this.canEndDay,
    this.canGift,
    this.canMakeCheckPayment,
    this.canMarkUnpayable,
    this.canRestoreCheck,
    this.canSeeActions,
    this.canSendCheckToCheckAccount,
    this.canTransferCheck,
    this.serverBranchId,
    this.isAdmin,
  });

  factory TerminalUser.fromJson(Map<String, dynamic> json) {
    return _$TerminalUserFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TerminalUserToJson(this);
  }
}
