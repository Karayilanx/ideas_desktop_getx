import 'package:json_annotation/json_annotation.dart';
part 'end_of_day_unpayable_report_model.g.dart';

@JsonSerializable()
class EndOfDayUnpayableReportModel {
  List<EndOfDayUnpayableCategoryDistributionModel>? categoryDistribution;
  List<EndOfDayUnpayableCategoryDistributionModel>? subCategoryDistribution;
  List<EndOfDayUnpayableCheckMenuItemModel>? checkMenuItems;
  List<EndOfDayUnpayableCheckModel>? unpayableChecks;
  double? totalAmount;
  double? checkAmountVerification;
  double? transactionVerification;
  EndOfDayUnpayableReportModel({
    this.categoryDistribution,
    this.subCategoryDistribution,
    this.checkMenuItems,
    this.unpayableChecks,
    this.totalAmount,
    this.checkAmountVerification,
    this.transactionVerification,
  });

  factory EndOfDayUnpayableReportModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayUnpayableReportModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayUnpayableReportModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayUnpayableCategoryDistributionModel {
  String? name;
  double? amount;
  EndOfDayUnpayableCategoryDistributionModel({
    this.name,
    this.amount,
  });

  factory EndOfDayUnpayableCategoryDistributionModel.fromJson(
      Map<String, dynamic> json) {
    return _$EndOfDayUnpayableCategoryDistributionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayUnpayableCategoryDistributionModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayUnpayableCheckMenuItemModel {
  String? name;
  double? quantity;
  double? price;
  EndOfDayUnpayableCheckMenuItemModel({
    this.name,
    this.quantity,
    this.price,
  });

  factory EndOfDayUnpayableCheckMenuItemModel.fromJson(
      Map<String, dynamic> json) {
    return _$EndOfDayUnpayableCheckMenuItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayUnpayableCheckMenuItemModelToJson(this);
  }
}

@JsonSerializable()
class EndOfDayUnpayableCheckModel {
  int? checkId;
  String? name;
  double? checkAmount;
  EndOfDayUnpayableCheckModel({
    this.checkId,
    this.name,
    this.checkAmount,
  });

  factory EndOfDayUnpayableCheckModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDayUnpayableCheckModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EndOfDayUnpayableCheckModelToJson(this);
  }
}
