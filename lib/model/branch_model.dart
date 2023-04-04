import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class NetworkInfoModel {
  String? ipAddress;
  String? networkName;
  String? type;
  NetworkInfoModel({this.ipAddress, this.networkName, this.type});

  factory NetworkInfoModel.fromJson(Map<String, dynamic> json) {
    return _$NetworkInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NetworkInfoModelToJson(this);
  }
}

@JsonSerializable()
class ServerChangeMsgModel {
  int? msgID;
  int? branchId;
  String? header;
  String? message;
  int? msgTypeId;

  ServerChangeMsgModel({
    this.msgID,
    this.branchId,
    this.header,
    this.message,
    this.msgTypeId,
  });

  factory ServerChangeMsgModel.fromJson(Map<String, dynamic> json) {
    return _$ServerChangeMsgModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$ServerChangeMsgModelToJson(this);
  }
}

@JsonSerializable()
class CheckServerChangesModel {
  int? changeCount;
  int? unsendEndOfDaysCount;
  ServerChangeMsgModel? message;

  CheckServerChangesModel({
    this.changeCount,
    this.message,
    this.unsendEndOfDaysCount,
  });

  factory CheckServerChangesModel.fromJson(Map<String, dynamic> json) {
    return _$CheckServerChangesModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckServerChangesModelToJson(this);
  }
}

@JsonSerializable()
class TerminalUserModel {
  int? branchId;
  int? terminalUserId;
  String? name;
  String? pin;
  bool? isActive;
  int? maxDiscountPercentage;
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
  bool? isAdmin;

  TerminalUserModel({
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
    this.isActive,
    this.maxDiscountPercentage,
    this.name,
    this.pin,
    this.terminalUserId,
    this.isAdmin,
  });

  factory TerminalUserModel.fromJson(Map<String, dynamic> json) {
    return _$TerminalUserModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TerminalUserModelToJson(this);
  }
}

@JsonSerializable()
class UpdateTerminalUsersModel {
  int? branchId;
  List<TerminalUserModel>? terminalUsers;

  UpdateTerminalUsersModel({
    this.branchId,
    this.terminalUsers,
  });

  factory UpdateTerminalUsersModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateTerminalUsersModelFromJson(json);
  }
  Map<String, Object?> toJson() {
    return _$UpdateTerminalUsersModelToJson(this);
  }
}
