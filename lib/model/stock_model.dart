import 'package:json_annotation/json_annotation.dart';
part 'stock_model.g.dart';

@JsonSerializable()
class UncalculatedEndOfDayModel {
  DateTime? endOfDayDate;
  int? endOfDayId;
  int? branchId;
  UncalculatedEndOfDayModel(
      {this.branchId, this.endOfDayId, this.endOfDayDate});

  factory UncalculatedEndOfDayModel.fromJson(Map<String, dynamic> json) {
    return _$UncalculatedEndOfDayModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$UncalculatedEndOfDayModelToJson(this);
  }
}
