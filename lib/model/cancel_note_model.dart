import 'package:json_annotation/json_annotation.dart';
part 'cancel_note_model.g.dart';

@JsonSerializable()
class CancelNoteOutput {
  int? cancelNoteId;
  int? branchId;
  String? note;

  CancelNoteOutput({this.branchId, this.cancelNoteId, this.note});

  factory CancelNoteOutput.fromJson(Map<String, dynamic> json) {
    return _$CancelNoteOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CancelNoteOutputToJson(this);
  }
}
