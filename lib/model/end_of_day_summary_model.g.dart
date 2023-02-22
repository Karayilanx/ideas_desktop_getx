// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDaySummaryReportModel _$EndOfDaySummaryReportModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDaySummaryReportModel(
      totalSales: json['totalSales'] == null
          ? null
          : TotalIncomeModel.fromJson(
              json['totalSales'] as Map<String, dynamic>),
      checkAccountReceivings: json['checkAccountReceivings'] == null
          ? null
          : TotalIncomeModel.fromJson(
              json['checkAccountReceivings'] as Map<String, dynamic>),
      totalIncome: json['totalIncome'] == null
          ? null
          : TotalIncomeModel.fromJson(
              json['totalIncome'] as Map<String, dynamic>),
      endorsementDistribution: json['endorsementDistribution'] == null
          ? null
          : EndorsementDistributionModel.fromJson(
              json['endorsementDistribution'] as Map<String, dynamic>),
      sellDistribution: json['sellDistribution'] == null
          ? null
          : SellDistributionModel.fromJson(
              json['sellDistribution'] as Map<String, dynamic>),
      expectedRevenue: json['expectedRevenue'] == null
          ? null
          : ExpectedRevenueModel.fromJson(
              json['expectedRevenue'] as Map<String, dynamic>),
      checkAccountSales: json['checkAccountSales'] == null
          ? null
          : CheckAccountSalesModel.fromJson(
              json['checkAccountSales'] as Map<String, dynamic>),
      totalPersonCount: json['totalPersonCount'] as int?,
    );

Map<String, dynamic> _$EndOfDaySummaryReportModelToJson(
        EndOfDaySummaryReportModel instance) =>
    <String, dynamic>{
      'totalSales': instance.totalSales,
      'checkAccountReceivings': instance.checkAccountReceivings,
      'totalIncome': instance.totalIncome,
      'endorsementDistribution': instance.endorsementDistribution,
      'sellDistribution': instance.sellDistribution,
      'expectedRevenue': instance.expectedRevenue,
      'checkAccountSales': instance.checkAccountSales,
      'totalPersonCount': instance.totalPersonCount,
    };

IncomeDetailModel _$IncomeDetailModelFromJson(Map<String, dynamic> json) =>
    IncomeDetailModel(
      amount: (json['amount'] as num).toDouble(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$IncomeDetailModelToJson(IncomeDetailModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'name': instance.name,
    };

TotalIncomeModel _$TotalIncomeModelFromJson(Map<String, dynamic> json) =>
    TotalIncomeModel(
      cash: (json['cash'] as num).toDouble(),
      creditCard: (json['creditCard'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      creditDetails: (json['creditDetails'] as List<dynamic>)
          .map((e) => IncomeDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cashDetails: (json['cashDetails'] as List<dynamic>)
          .map((e) => IncomeDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalIncomeModelToJson(TotalIncomeModel instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'creditCard': instance.creditCard,
      'total': instance.total,
      'creditDetails': instance.creditDetails,
      'cashDetails': instance.cashDetails,
    };

EndorsementDistributionModel _$EndorsementDistributionModelFromJson(
        Map<String, dynamic> json) =>
    EndorsementDistributionModel(
      restaurant: (json['restaurant'] as num).toDouble(),
      delivery: (json['delivery'] as num).toDouble(),
      getir: (json['getir'] as num).toDouble(),
      yemeksepeti: (json['yemeksepeti'] as num).toDouble(),
      fuudy: (json['fuudy'] as num).toDouble(),
      subTotal: (json['subTotal'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      checkAccount: (json['checkAccount'] as num).toDouble(),
    );

Map<String, dynamic> _$EndorsementDistributionModelToJson(
        EndorsementDistributionModel instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
      'delivery': instance.delivery,
      'getir': instance.getir,
      'yemeksepeti': instance.yemeksepeti,
      'subTotal': instance.subTotal,
      'discount': instance.discount,
      'fuudy': instance.fuudy,
      'total': instance.total,
      'checkAccount': instance.checkAccount,
    };

SellDistributionModel _$SellDistributionModelFromJson(
        Map<String, dynamic> json) =>
    SellDistributionModel(
      categorySales: (json['categorySales'] as List<dynamic>)
          .map((e) => CategorySellModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSales: (json['totalSales'] as num).toDouble(),
      checkAccountBorrowings:
          (json['checkAccountBorrowings'] as num).toDouble(),
      checkAccountReceivings:
          (json['checkAccountReceivings'] as num).toDouble(),
      discounts: (json['discounts'] as num).toDouble(),
      income: (json['income'] as num).toDouble(),
      unpayable: (json['unpayable'] as num).toDouble(),
    );

Map<String, dynamic> _$SellDistributionModelToJson(
        SellDistributionModel instance) =>
    <String, dynamic>{
      'categorySales': instance.categorySales,
      'totalSales': instance.totalSales,
      'checkAccountBorrowings': instance.checkAccountBorrowings,
      'checkAccountReceivings': instance.checkAccountReceivings,
      'discounts': instance.discounts,
      'income': instance.income,
      'unpayable': instance.unpayable,
    };

CategorySellModel _$CategorySellModelFromJson(Map<String, dynamic> json) =>
    CategorySellModel(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      amount: (json['amount'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$CategorySellModelToJson(CategorySellModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'amount': instance.amount,
      'quantity': instance.quantity,
    };

ExpectedRevenueModel _$ExpectedRevenueModelFromJson(
        Map<String, dynamic> json) =>
    ExpectedRevenueModel(
      totalSales: (json['totalSales'] as num).toDouble(),
      checkAccountReceivings:
          (json['checkAccountReceivings'] as num).toDouble(),
      subTotal: (json['subTotal'] as num).toDouble(),
      totalActiveCheck: (json['totalActiveCheck'] as num).toDouble(),
      expectedRevenue: (json['expectedRevenue'] as num).toDouble(),
      totalFastSell: (json['totalFastSell'] as num).toDouble(),
      totalGetir: (json['totalGetir'] as num).toDouble(),
      totalRestaurant: (json['totalRestaurant'] as num).toDouble(),
      totalYemeksepeti: (json['totalYemeksepeti'] as num).toDouble(),
      totalFuudy: (json['totalFuudy'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpectedRevenueModelToJson(
        ExpectedRevenueModel instance) =>
    <String, dynamic>{
      'totalSales': instance.totalSales,
      'checkAccountReceivings': instance.checkAccountReceivings,
      'subTotal': instance.subTotal,
      'totalActiveCheck': instance.totalActiveCheck,
      'expectedRevenue': instance.expectedRevenue,
      'totalYemeksepeti': instance.totalYemeksepeti,
      'totalGetir': instance.totalGetir,
      'totalFuudy': instance.totalFuudy,
      'totalFastSell': instance.totalFastSell,
      'totalRestaurant': instance.totalRestaurant,
    };

CheckAccountSalesModel _$CheckAccountSalesModelFromJson(
        Map<String, dynamic> json) =>
    CheckAccountSalesModel(
      checkAccountSales: (json['checkAccountSales'] as List<dynamic>)
          .map((e) => CheckAccountSaleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$CheckAccountSalesModelToJson(
        CheckAccountSalesModel instance) =>
    <String, dynamic>{
      'checkAccountSales': instance.checkAccountSales,
      'totalAmount': instance.totalAmount,
    };

CheckAccountSaleModel _$CheckAccountSaleModelFromJson(
        Map<String, dynamic> json) =>
    CheckAccountSaleModel(
      checkAccountId: json['checkAccountId'] as int,
      checkAccountName: json['checkAccountName'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$CheckAccountSaleModelToJson(
        CheckAccountSaleModel instance) =>
    <String, dynamic>{
      'checkAccountId': instance.checkAccountId,
      'checkAccountName': instance.checkAccountName,
      'amount': instance.amount,
    };
