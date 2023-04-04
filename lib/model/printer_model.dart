import 'package:json_annotation/json_annotation.dart';

import 'check_model.dart';

part 'printer_model.g.dart';

@JsonSerializable()
class PrintStoppedItemsInput {
  int? checkId;
  int? terminalUserId;
  int branchId;
  List<GroupedCheckItem>? items;

  PrintStoppedItemsInput({
    this.checkId,
    this.items,
    this.terminalUserId,
    required this.branchId,
  });

  factory PrintStoppedItemsInput.fromJson(Map<String, dynamic> json) {
    return _$PrintStoppedItemsInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PrintStoppedItemsInputToJson(this);
  }
}

@JsonSerializable()
class PrinterOutput {
  int? branchId;
  int? printerId;
  String? printerName;
  bool? isCashPrinter;
  bool? isGeneric;
  bool? isSlipPrinter;

  PrinterOutput({
    this.branchId,
    this.isCashPrinter,
    this.printerId,
    this.printerName,
    this.isGeneric,
    this.isSlipPrinter,
  });

  factory PrinterOutput.fromJson(Map<String, dynamic> json) {
    return _$PrinterOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PrinterOutputToJson(this);
  }
}
