// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuudy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuudyCheckDetailsModel _$FuudyCheckDetailsModelFromJson(
        Map<String, dynamic> json) =>
    FuudyCheckDetailsModel(
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
      isRestaurantCourier: json['isRestaurantCourier'] as bool?,
      paymentTypeString: json['paymentTypeString'] as String?,
      deliveryPaymentTypeId: json['deliveryPaymentTypeId'] as int?,
      deliveryStatusTypeId: json['deliveryStatusTypeId'] as int?,
      checkNote: json['checkNote'] as String?,
    );

Map<String, dynamic> _$FuudyCheckDetailsModelToJson(
        FuudyCheckDetailsModel instance) =>
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
      'isRestaurantCourier': instance.isRestaurantCourier,
      'deliveryPaymentTypeId': instance.deliveryPaymentTypeId,
      'deliveryStatusTypeId': instance.deliveryStatusTypeId,
      'paymentTypeString': instance.paymentTypeString,
      'checkNote': instance.checkNote,
    };
