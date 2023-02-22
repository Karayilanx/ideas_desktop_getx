// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_sales_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDaySaleReportModel _$EndOfDaySaleReportModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDaySaleReportModel(
      categoryName: json['categoryName'] as String?,
      subCategoryName: json['subCategoryName'] as String?,
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EndOfDaySaleReportModelToJson(
        EndOfDaySaleReportModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'subCategoryName': instance.subCategoryName,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
    };

EndOfDayHourlySaleModel _$EndOfDayHourlySaleModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayHourlySaleModel(
      saleQuantity: (json['saleQuantity'] as num?)?.toDouble(),
      saleAmount: (json['saleAmount'] as num?)?.toDouble(),
      hour: json['hour'] as int?,
    );

Map<String, dynamic> _$EndOfDayHourlySaleModelToJson(
        EndOfDayHourlySaleModel instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'saleAmount': instance.saleAmount,
      'saleQuantity': instance.saleQuantity,
    };
