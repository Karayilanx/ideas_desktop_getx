import 'package:json_annotation/json_annotation.dart';

part 'end_of_day_summary_model.g.dart';

@JsonSerializable()
class EndOfDaySummaryReportModel {
  TotalIncomeModel? totalSales;
  TotalIncomeModel? checkAccountReceivings;
  TotalIncomeModel? totalIncome;
  EndorsementDistributionModel? endorsementDistribution;
  SellDistributionModel? sellDistribution;
  ExpectedRevenueModel? expectedRevenue;
  CheckAccountSalesModel? checkAccountSales;
  int? totalPersonCount;
  EndOfDaySummaryReportModel({
    this.totalSales,
    this.checkAccountReceivings,
    this.totalIncome,
    this.endorsementDistribution,
    this.sellDistribution,
    this.expectedRevenue,
    this.checkAccountSales,
    this.totalPersonCount,
  });

  factory EndOfDaySummaryReportModel.fromJson(Map<String, dynamic> json) {
    return _$EndOfDaySummaryReportModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$EndOfDaySummaryReportModelToJson(this);
  }
}

@JsonSerializable()
class IncomeDetailModel {
  double amount;
  String name;

  IncomeDetailModel({
    required this.amount,
    required this.name,
  });

  factory IncomeDetailModel.fromJson(Map<String, dynamic> json) {
    return _$IncomeDetailModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$IncomeDetailModelToJson(this);
  }
}

@JsonSerializable()
class TotalIncomeModel {
  double cash;
  double creditCard;
  double total;
  List<IncomeDetailModel> creditDetails;
  List<IncomeDetailModel> cashDetails;

  TotalIncomeModel({
    required this.cash,
    required this.creditCard,
    required this.total,
    required this.creditDetails,
    required this.cashDetails,
  });

  factory TotalIncomeModel.fromJson(Map<String, dynamic> json) {
    return _$TotalIncomeModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TotalIncomeModelToJson(this);
  }
}

@JsonSerializable()
class EndorsementDistributionModel {
  double restaurant;
  double delivery;
  double getir;
  double yemeksepeti;
  double subTotal;
  double discount;
  double fuudy;
  double total;
  double checkAccount;
  EndorsementDistributionModel({
    required this.restaurant,
    required this.delivery,
    required this.getir,
    required this.yemeksepeti,
    required this.fuudy,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.checkAccount,
  });

  factory EndorsementDistributionModel.fromJson(Map<String, dynamic> json) {
    return _$EndorsementDistributionModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$EndorsementDistributionModelToJson(this);
  }
}

@JsonSerializable()
class SellDistributionModel {
  List<CategorySellModel> categorySales;
  double totalSales;
  double checkAccountBorrowings;
  double checkAccountReceivings;
  double discounts;
  double income;
  double unpayable;
  SellDistributionModel({
    required this.categorySales,
    required this.totalSales,
    required this.checkAccountBorrowings,
    required this.checkAccountReceivings,
    required this.discounts,
    required this.income,
    required this.unpayable,
  });

  factory SellDistributionModel.fromJson(Map<String, dynamic> json) {
    return _$SellDistributionModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$SellDistributionModelToJson(this);
  }
}

@JsonSerializable()
class CategorySellModel {
  int categoryId;
  String categoryName;
  double amount;
  double quantity;
  CategorySellModel({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.quantity,
  });

  factory CategorySellModel.fromJson(Map<String, dynamic> json) {
    return _$CategorySellModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CategorySellModelToJson(this);
  }
}

@JsonSerializable()
class ExpectedRevenueModel {
  double totalSales;
  double checkAccountReceivings;
  double subTotal;
  double totalActiveCheck;
  double expectedRevenue;
  double totalYemeksepeti;
  double totalGetir;
  double totalFuudy;
  double totalFastSell;
  double totalRestaurant;
  ExpectedRevenueModel({
    required this.totalSales,
    required this.checkAccountReceivings,
    required this.subTotal,
    required this.totalActiveCheck,
    required this.expectedRevenue,
    required this.totalFastSell,
    required this.totalGetir,
    required this.totalRestaurant,
    required this.totalYemeksepeti,
    required this.totalFuudy,
  });

  factory ExpectedRevenueModel.fromJson(Map<String, dynamic> json) {
    return _$ExpectedRevenueModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$ExpectedRevenueModelToJson(this);
  }
}

@JsonSerializable()
class CheckAccountSalesModel {
  List<CheckAccountSaleModel> checkAccountSales;
  double totalAmount;
  CheckAccountSalesModel({
    required this.checkAccountSales,
    required this.totalAmount,
  });

  factory CheckAccountSalesModel.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountSalesModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountSalesModelToJson(this);
  }
}

@JsonSerializable()
class CheckAccountSaleModel {
  int checkAccountId;
  String checkAccountName;
  double amount;
  CheckAccountSaleModel({
    required this.checkAccountId,
    required this.checkAccountName,
    required this.amount,
  });

  factory CheckAccountSaleModel.fromJson(Map<String, dynamic> json) {
    return _$CheckAccountSaleModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckAccountSaleModelToJson(this);
  }
}
