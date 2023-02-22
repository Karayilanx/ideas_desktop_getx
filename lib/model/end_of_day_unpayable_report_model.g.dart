// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_of_day_unpayable_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndOfDayUnpayableReportModel _$EndOfDayUnpayableReportModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayUnpayableReportModel(
      categoryDistribution: (json['categoryDistribution'] as List<dynamic>?)
          ?.map((e) => EndOfDayUnpayableCategoryDistributionModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      subCategoryDistribution:
          (json['subCategoryDistribution'] as List<dynamic>?)
              ?.map((e) => EndOfDayUnpayableCategoryDistributionModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      checkMenuItems: (json['checkMenuItems'] as List<dynamic>?)
          ?.map((e) => EndOfDayUnpayableCheckMenuItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      unpayableChecks: (json['unpayableChecks'] as List<dynamic>?)
          ?.map((e) =>
              EndOfDayUnpayableCheckModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      checkAmountVerification:
          (json['checkAmountVerification'] as num?)?.toDouble(),
      transactionVerification:
          (json['transactionVerification'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EndOfDayUnpayableReportModelToJson(
        EndOfDayUnpayableReportModel instance) =>
    <String, dynamic>{
      'categoryDistribution': instance.categoryDistribution,
      'subCategoryDistribution': instance.subCategoryDistribution,
      'checkMenuItems': instance.checkMenuItems,
      'unpayableChecks': instance.unpayableChecks,
      'totalAmount': instance.totalAmount,
      'checkAmountVerification': instance.checkAmountVerification,
      'transactionVerification': instance.transactionVerification,
    };

EndOfDayUnpayableCategoryDistributionModel
    _$EndOfDayUnpayableCategoryDistributionModelFromJson(
            Map<String, dynamic> json) =>
        EndOfDayUnpayableCategoryDistributionModel(
          name: json['name'] as String?,
          amount: (json['amount'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$EndOfDayUnpayableCategoryDistributionModelToJson(
        EndOfDayUnpayableCategoryDistributionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
    };

EndOfDayUnpayableCheckMenuItemModel
    _$EndOfDayUnpayableCheckMenuItemModelFromJson(Map<String, dynamic> json) =>
        EndOfDayUnpayableCheckMenuItemModel(
          name: json['name'] as String?,
          quantity: (json['quantity'] as num?)?.toDouble(),
          price: (json['price'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$EndOfDayUnpayableCheckMenuItemModelToJson(
        EndOfDayUnpayableCheckMenuItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
    };

EndOfDayUnpayableCheckModel _$EndOfDayUnpayableCheckModelFromJson(
        Map<String, dynamic> json) =>
    EndOfDayUnpayableCheckModel(
      checkId: json['checkId'] as int?,
      name: json['name'] as String?,
      checkAmount: (json['checkAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EndOfDayUnpayableCheckModelToJson(
        EndOfDayUnpayableCheckModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'name': instance.name,
      'checkAmount': instance.checkAmount,
    };
