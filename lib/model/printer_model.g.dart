// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrintStoppedItemsInput _$PrintStoppedItemsInputFromJson(
        Map<String, dynamic> json) =>
    PrintStoppedItemsInput(
      checkId: json['checkId'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GroupedCheckItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      terminalUserId: json['terminalUserId'] as int?,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$PrintStoppedItemsInputToJson(
        PrintStoppedItemsInput instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'terminalUserId': instance.terminalUserId,
      'branchId': instance.branchId,
      'items': instance.items,
    };

PrinterOutput _$PrinterOutputFromJson(Map<String, dynamic> json) =>
    PrinterOutput(
      branchId: json['branchId'] as int?,
      isCashPrinter: json['isCashPrinter'] as bool?,
      printerId: json['printerId'] as int?,
      printerName: json['printerName'] as String?,
      isGeneric: json['isGeneric'] as bool?,
      isSlipPrinter: json['isSlipPrinter'] as bool?,
    );

Map<String, dynamic> _$PrinterOutputToJson(PrinterOutput instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'printerId': instance.printerId,
      'printerName': instance.printerName,
      'isCashPrinter': instance.isCashPrinter,
      'isGeneric': instance.isGeneric,
      'isSlipPrinter': instance.isSlipPrinter,
    };
