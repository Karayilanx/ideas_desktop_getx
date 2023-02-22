// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import 'check_model.dart';
part 'table_model.g.dart';

enum TableStatusTypeEnum { Empty, HasOpenCheck, HasBillSent }

@JsonSerializable()
class TableWithDetails {
  int? tableId;
  String? name;
  double? amount;
  String? terminalUserName;
  int? status;
  @JsonKey(defaultValue: -1)
  int? checkId;
  int? minute;
  bool? disablePersonCount;
  CheckDetailsModel? checkDetail;

  TableWithDetails({
    this.name,
    this.amount,
    this.checkDetail,
    this.checkId,
    this.status,
    this.tableId,
    this.terminalUserName,
    this.minute,
    this.disablePersonCount,
  });

  factory TableWithDetails.fromJson(Map<String, dynamic> json) {
    return _$TableWithDetailsFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TableWithDetailsToJson(this);
  }
}
