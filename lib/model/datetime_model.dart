import 'package:json_annotation/json_annotation.dart';

part 'datetime_model.g.dart';

@JsonSerializable()
class DateTimeModel {
  DateTime? value;

  DateTimeModel({this.value});

  factory DateTimeModel.fromJson(Map<String, dynamic> json) {
    return _$DateTimeModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DateTimeModelToJson(this);
  }
}
