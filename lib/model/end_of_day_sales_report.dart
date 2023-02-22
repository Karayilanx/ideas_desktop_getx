import 'package:json_annotation/json_annotation.dart';
part 'end_of_day_sales_report.g.dart';

@JsonSerializable()
class EndOfDaySaleReportModel {
  String? categoryName;
  String? subCategoryName;
  String? name;
  double? quantity;
  double? price;
  EndOfDaySaleReportModel({
    this.categoryName,
    this.subCategoryName,
    this.name,
    this.quantity,
    this.price,
  });

  factory EndOfDaySaleReportModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDaySaleReportModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDaySaleReportModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayHourlySaleModel {
  int? hour;
  double? saleAmount;
  double? saleQuantity;
  EndOfDayHourlySaleModel({
    this.saleQuantity,
    this.saleAmount,
    this.hour,
  });

  factory EndOfDayHourlySaleModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayHourlySaleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayHourlySaleModelToJson(this);
  }
}
