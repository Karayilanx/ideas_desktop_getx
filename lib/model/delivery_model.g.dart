// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryModel _$DeliveryModelFromJson(Map<String, dynamic> json) =>
    DeliveryModel(
      branchId: json['branchId'] as int?,
      checkId: json['checkId'] as int?,
      deliveryCustomerAddressId: json['deliveryCustomerAddressId'] as int?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      deliveryId: json['deliveryId'] as int?,
      deliveryPaymentTypeId: json['deliveryPaymentTypeId'] as int?,
      deliveryStatusTypeId: json['deliveryStatusTypeId'] as int?,
      deliveryCustomerId: json['deliveryCustomerId'] as int?,
    );

Map<String, dynamic> _$DeliveryModelToJson(DeliveryModel instance) =>
    <String, dynamic>{
      'deliveryId': instance.deliveryId,
      'checkId': instance.checkId,
      'branchId': instance.branchId,
      'deliveryCustomerAddressId': instance.deliveryCustomerAddressId,
      'deliveryPaymentTypeId': instance.deliveryPaymentTypeId,
      'deliveryStatusTypeId': instance.deliveryStatusTypeId,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'deliveryCustomerId': instance.deliveryCustomerId,
    };

DeliveryListItem _$DeliveryListItemFromJson(Map<String, dynamic> json) =>
    DeliveryListItem(
      address: json['address'] as String?,
      addressDefinition: json['addressDefinition'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      customerFullName: json['customerFullName'] as String?,
      customerPhoneNumber: json['customerPhoneNumber'] as String?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      deliveryPaymentTypeId: json['deliveryPaymentTypeId'] as int?,
      checkId: json['checkId'] as int?,
      deliveryStatusTypeId: json['deliveryStatusTypeId'] as int?,
      deliverySourceTypeId: json['deliverySourceTypeId'] as int?,
      getirId: json['getirId'] as String?,
      getirPaymentMethodTypeId: json['getirPaymentMethodTypeId'] as int?,
      isScheduled: json['isScheduled'] as bool?,
      isTakeAway: json['isTakeAway'] as bool?,
      getirStatus: json['getirStatus'] as int?,
      yemeksepetiId: json['yemeksepetiId'] as String?,
      yemeksepetiPaymentMethodTypeId:
          json['yemeksepetiPaymentMethodTypeId'] as int?,
      yemeksepetiStatus: json['yemeksepetiStatus'] as int?,
      integrationPaymentString: json['integrationPaymentString'] as String?,
      region: json['region'] as String?,
      getirGetirsin: json['getirGetirsin'] as bool?,
      fuudyId: json['fuudyId'] as int?,
      courier: json['courier'] == null
          ? null
          : CourierModel.fromJson(json['courier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeliveryListItemToJson(DeliveryListItem instance) =>
    <String, dynamic>{
      'customerFullName': instance.customerFullName,
      'customerPhoneNumber': instance.customerPhoneNumber,
      'address': instance.address,
      'addressDefinition': instance.addressDefinition,
      'getirId': instance.getirId,
      'fuudyId': instance.fuudyId,
      'yemeksepetiId': instance.yemeksepetiId,
      'region': instance.region,
      'amount': instance.amount,
      'createDate': instance.createDate?.toIso8601String(),
      'integrationPaymentString': instance.integrationPaymentString,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'checkId': instance.checkId,
      'deliveryPaymentTypeId': instance.deliveryPaymentTypeId,
      'deliveryStatusTypeId': instance.deliveryStatusTypeId,
      'deliverySourceTypeId': instance.deliverySourceTypeId,
      'getirPaymentMethodTypeId': instance.getirPaymentMethodTypeId,
      'yemeksepetiPaymentMethodTypeId': instance.yemeksepetiPaymentMethodTypeId,
      'getirStatus': instance.getirStatus,
      'yemeksepetiStatus': instance.yemeksepetiStatus,
      'isTakeAway': instance.isTakeAway,
      'isScheduled': instance.isScheduled,
      'getirGetirsin': instance.getirGetirsin,
      'courier': instance.courier,
    };

DeliveryCustomerModel _$DeliveryCustomerModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryCustomerModel(
      brandId: json['brandId'] as int?,
      countryCode: json['countryCode'] as String?,
      deliveryCustomerAddresses: (json['deliveryCustomerAddresses']
              as List<dynamic>?)
          ?.map((e) =>
              DeliveryCustomerAddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryCustomerId: json['deliveryCustomerId'] as int?,
      lastName: json['lastName'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$DeliveryCustomerModelToJson(
        DeliveryCustomerModel instance) =>
    <String, dynamic>{
      'deliveryCustomerId': instance.deliveryCustomerId,
      'name': instance.name,
      'lastName': instance.lastName,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'deliveryCustomerAddresses': instance.deliveryCustomerAddresses,
      'brandId': instance.brandId,
    };

DeliveryCustomerTableRowModel _$DeliveryCustomerTableRowModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryCustomerTableRowModel(
      brandId: json['brandId'] as int?,
      countryCode: json['countryCode'] as String?,
      deliveryCustomerId: json['deliveryCustomerId'] as int?,
      lastName: json['lastName'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      addressTitle: json['addressTitle'] as String?,
      deliveryCustomerAddressId: json['deliveryCustomerAddressId'] as int?,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$DeliveryCustomerTableRowModelToJson(
        DeliveryCustomerTableRowModel instance) =>
    <String, dynamic>{
      'deliveryCustomerId': instance.deliveryCustomerId,
      'name': instance.name,
      'lastName': instance.lastName,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'brandId': instance.brandId,
      'deliveryCustomerAddressId': instance.deliveryCustomerAddressId,
      'addressTitle': instance.addressTitle,
      'address': instance.address,
      'fullName': instance.fullName,
    };

DeliveryCustomerAddressModel _$DeliveryCustomerAddressModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryCustomerAddressModel(
      address: json['address'] as String?,
      addressDefinition: json['addressDefinition'] as String?,
      addressTitle: json['addressTitle'] as String?,
      deliveryCustomerAddressId: json['deliveryCustomerAddressId'] as int?,
      deliveryCustomerId: json['deliveryCustomerId'] as int?,
    );

Map<String, dynamic> _$DeliveryCustomerAddressModelToJson(
        DeliveryCustomerAddressModel instance) =>
    <String, dynamic>{
      'deliveryCustomerAddressId': instance.deliveryCustomerAddressId,
      'deliveryCustomerId': instance.deliveryCustomerId,
      'address': instance.address,
      'addressDefinition': instance.addressDefinition,
      'addressTitle': instance.addressTitle,
    };

CourierModel _$CourierModelFromJson(Map<String, dynamic> json) => CourierModel(
      branchId: json['branchId'] as int?,
      courierId: json['courierId'] as int?,
      courierName: json['courierName'] as String?,
    );

Map<String, dynamic> _$CourierModelToJson(CourierModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'courierId': instance.courierId,
      'courierName': instance.courierName,
    };
