// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yemeksepeti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YemeksepetiCheckDetailsModel _$YemeksepetiCheckDetailsModelFromJson(
        Map<String, dynamic> json) =>
    YemeksepetiCheckDetailsModel(
      checkId: json['checkId'] as int?,
      status: json['status'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      isScheduled: json['isScheduled'] as bool?,
      basketItems: (json['basketItems'] as List<dynamic>?)
          ?.map((e) => CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      payments: json['payments'] == null
          ? null
          : CheckPaymentsModel.fromJson(
              json['payments'] as Map<String, dynamic>),
      customerName: json['customerName'] as String?,
      customerPhoneNumber: json['customerPhoneNumber'] as String?,
      customerAddress: json['customerAddress'] as String?,
      customerAddressDefinition: json['customerAddressDefinition'] as String?,
      vale: json['vale'] as bool?,
      yemeksepetiPaymentTypeId: json['yemeksepetiPaymentTypeId'] as int?,
      checkNote: json['checkNote'] as String?,
      paymentTypeString: json['paymentTypeString'] as String?,
      deliveryPaymentTypeId: json['deliveryPaymentTypeId'] as int?,
      deliveryStatusTypeId: json['deliveryStatusTypeId'] as int?,
    );

Map<String, dynamic> _$YemeksepetiCheckDetailsModelToJson(
        YemeksepetiCheckDetailsModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'status': instance.status,
      'createDate': instance.createDate?.toIso8601String(),
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'isScheduled': instance.isScheduled,
      'basketItems': instance.basketItems,
      'payments': instance.payments,
      'customerName': instance.customerName,
      'customerPhoneNumber': instance.customerPhoneNumber,
      'customerAddress': instance.customerAddress,
      'customerAddressDefinition': instance.customerAddressDefinition,
      'vale': instance.vale,
      'yemeksepetiPaymentTypeId': instance.yemeksepetiPaymentTypeId,
      'deliveryPaymentTypeId': instance.deliveryPaymentTypeId,
      'deliveryStatusTypeId': instance.deliveryStatusTypeId,
      'checkNote': instance.checkNote,
      'paymentTypeString': instance.paymentTypeString,
    };

YemeksepetiRejectReason _$YemeksepetiRejectReasonFromJson(
        Map<String, dynamic> json) =>
    YemeksepetiRejectReason(
      reasonId: json['reasonId'] as int?,
      reasonName: json['reasonName'] as String?,
    );

Map<String, dynamic> _$YemeksepetiRejectReasonToJson(
        YemeksepetiRejectReason instance) =>
    <String, dynamic>{
      'reasonId': instance.reasonId,
      'reasonName': instance.reasonName,
    };

YemeksepetiRestaurantModel _$YemeksepetiRestaurantModelFromJson(
        Map<String, dynamic> json) =>
    YemeksepetiRestaurantModel(
      catalogName: json['catalogName'] as String?,
      categoryName: json['categoryName'] as String?,
      displayName: json['displayName'] as String?,
      serviceTime: json['serviceTime'] as int?,
      yemeksepetiRestaurantId: json['yemeksepetiRestaurantId'] as String?,
      isVale: json['isVale'] as bool?,
    );

Map<String, dynamic> _$YemeksepetiRestaurantModelToJson(
        YemeksepetiRestaurantModel instance) =>
    <String, dynamic>{
      'catalogName': instance.catalogName,
      'categoryName': instance.categoryName,
      'displayName': instance.displayName,
      'serviceTime': instance.serviceTime,
      'yemeksepetiRestaurantId': instance.yemeksepetiRestaurantId,
      'isVale': instance.isVale,
    };
