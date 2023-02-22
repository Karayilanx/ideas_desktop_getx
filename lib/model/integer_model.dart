import 'package:json_annotation/json_annotation.dart';
part 'integer_model.g.dart';

@JsonSerializable()
class IntegerModel {
  int? value;

  IntegerModel({this.value});

  factory IntegerModel.fromJson(Map<String, dynamic> json) {
    return _$IntegerModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$IntegerModelToJson(this);
  }
}
