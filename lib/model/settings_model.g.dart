// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      isPersonCountRequired: json['isPersonCountRequired'] as bool?,
      settingId: json['settingId'] as int?,
      autoLock: json['autoLock'] as bool?,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'settingId': instance.settingId,
      'isPersonCountRequired': instance.isPersonCountRequired,
      'autoLock': instance.autoLock,
    };
