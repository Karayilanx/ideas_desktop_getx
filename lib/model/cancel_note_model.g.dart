// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelNoteOutput _$CancelNoteOutputFromJson(Map<String, dynamic> json) =>
    CancelNoteOutput(
      branchId: json['branchId'] as int?,
      cancelNoteId: json['cancelNoteId'] as int?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CancelNoteOutputToJson(CancelNoteOutput instance) =>
    <String, dynamic>{
      'cancelNoteId': instance.cancelNoteId,
      'branchId': instance.branchId,
      'note': instance.note,
    };
