import 'package:json_annotation/json_annotation.dart';
part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  int? settingId;
  bool? isPersonCountRequired;
  bool? autoLock;
  SettingsModel({
    this.isPersonCountRequired,
    this.settingId,
    this.autoLock,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return _$SettingsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$SettingsModelToJson(this);
  }
}
