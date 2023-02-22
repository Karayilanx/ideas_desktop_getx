import 'package:json_annotation/json_annotation.dart';
part 'end_of_day_cancel_report_model.g.dart';

@JsonSerializable()
class EndOfDayCancelModel {
  int? checkId;
  String? checkName;
  String? checkMenuItemName;
  double? quantity;
  double? amount;
  DateTime? orderDate;
  DateTime? cancelDate;
  String? cancelType;
  String? cancelNote;

  EndOfDayCancelModel({
    this.amount,
    this.cancelDate,
    this.cancelNote,
    this.cancelType,
    this.checkId,
    this.checkMenuItemName,
    this.checkName,
    this.orderDate,
    this.quantity,
  });

  factory EndOfDayCancelModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayCancelModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$EndOfDayCancelModelToJson(this);
  }
}
