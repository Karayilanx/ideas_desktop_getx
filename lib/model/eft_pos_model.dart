import 'package:json_annotation/json_annotation.dart';

part 'eft_pos_model.g.dart';

@JsonSerializable()
class EftPosModel {
  int? eftPosId;
  String? eftPosName;
  String? ipAddress;
  String? fiscalId;
  bool? isActive;
  List<int>? checkAccountIds;
  String? checkAccountName;
  int? branchId;
  String? acquirerId;

  EftPosModel({
    this.eftPosId,
    this.eftPosName,
    this.ipAddress,
    this.fiscalId,
    this.isActive,
    this.checkAccountIds,
    this.checkAccountName,
    this.branchId,
    this.acquirerId,
  });

  factory EftPosModel.fromJson(Map<String, dynamic> json) =>
      _$EftPosModelFromJson(json);

  Map<String, dynamic> toJson() => _$EftPosModelToJson(this);
}

@JsonSerializable()
class OkcDeptModel {
  int? okcDeptId;
  int? deptId;
  String? deptName;
  int? kdv;
  bool? isActive;
  int? eftPosId;

  OkcDeptModel({
    this.okcDeptId,
    this.deptId,
    this.deptName,
    this.kdv,
    this.isActive,
    this.eftPosId,
  });

  factory OkcDeptModel.fromJson(Map<String, dynamic> json) =>
      _$OkcDeptModelFromJson(json);

  Map<String, dynamic> toJson() => _$OkcDeptModelToJson(this);
}

@JsonSerializable()
class DeptSellInput {
  int? branchId;
  int? eftPosId;
  int? deptId;
  String? deptName;
  double? amount;
  int? paymentType;

  DeptSellInput(
    this.branchId,
    this.eftPosId,
    this.deptId,
    this.deptName,
    this.amount,
    this.paymentType,
  );

  factory DeptSellInput.fromJson(Map<String, dynamic> json) =>
      _$DeptSellInputFromJson(json);

  Map<String, dynamic> toJson() => _$DeptSellInputToJson(this);
}
