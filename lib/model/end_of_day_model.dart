import 'package:json_annotation/json_annotation.dart';

part 'end_of_day_model.g.dart';

@JsonSerializable()
class CheckCountModel {
  int? yemeksepeti;
  int? getir;
  int? delivery;
  int? fastSell;
  int? alias;
  int? table;

  CheckCountModel({
    this.alias,
    this.delivery,
    this.fastSell,
    this.getir,
    this.table,
    this.yemeksepeti,
  });

  factory CheckCountModel.fromJson(Map<String, dynamic> json) {
    return _$CheckCountModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckCountModelToJson(this);
  }
}
