// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getir_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetirCheckDetailsModel _$GetirCheckDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetirCheckDetailsModel(
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
      customerAddress: json['customerAddress'] as String?,
      customerAddressDefinition: json['customerAddressDefinition'] as String?,
      customerName: json['customerName'] as String?,
      customerPhoneNumber: json['customerPhoneNumber'] as String?,
      getirGetirsin: json['getirGetirsin'] as bool?,
      getirPaymentTypeId: json['getirPaymentTypeId'] as int?,
      paymentTypeString: json['paymentTypeString'] as String?,
      deliveryPaymentTypeId: json['deliveryPaymentTypeId'] as int?,
      deliveryStatusTypeId: json['deliveryStatusTypeId'] as int?,
      checkNote: json['checkNote'] as String?,
    );

Map<String, dynamic> _$GetirCheckDetailsModelToJson(
        GetirCheckDetailsModel instance) =>
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
      'getirGetirsin': instance.getirGetirsin,
      'getirPaymentTypeId': instance.getirPaymentTypeId,
      'deliveryPaymentTypeId': instance.deliveryPaymentTypeId,
      'deliveryStatusTypeId': instance.deliveryStatusTypeId,
      'paymentTypeString': instance.paymentTypeString,
      'checkNote': instance.checkNote,
    };

GetirResultOutput _$GetirResultOutputFromJson(Map<String, dynamic> json) =>
    GetirResultOutput(
      result: json['result'] as bool?,
    );

Map<String, dynamic> _$GetirResultOutputToJson(GetirResultOutput instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

GetirCancelOption _$GetirCancelOptionFromJson(Map<String, dynamic> json) =>
    GetirCancelOption(
      id: json['id'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetirCancelOptionToJson(GetirCancelOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
    };

GetirRestaurantStatusModel _$GetirRestaurantStatusModelFromJson(
        Map<String, dynamic> json) =>
    GetirRestaurantStatusModel(
      averagePreparationTime: json['averagePreparationTime'] as int?,
      isCourierAvailable: json['isCourierAvailable'] as bool?,
      restaurantId: json['restaurantId'] as String?,
      restaurantName: json['restaurantName'] as String?,
      restaurantStatus: json['restaurantStatus'] as int?,
    );

Map<String, dynamic> _$GetirRestaurantStatusModelToJson(
        GetirRestaurantStatusModel instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'averagePreparationTime': instance.averagePreparationTime,
      'restaurantStatus': instance.restaurantStatus,
      'isCourierAvailable': instance.isCourierAvailable,
    };
