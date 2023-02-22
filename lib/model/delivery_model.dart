// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'delivery_model.g.dart';

enum DeliveryPaymentTypeEnum { Cash, CreditCard, Account, Other }

enum DeliverySourceTypeEnum {
  POS,
  Getir,
  Yemeksepeti,
}

enum DeliveryStatusTypeEnum {
  NewOrder,
  Preparing,
  OnTheWay,
  Completed,
  Cancelled,
  Delivered,
  WaitingForSchedule,
  WaitingForGetirCourierToFinish,
}

@JsonSerializable()
class DeliveryModel {
  int? deliveryId;

  int? checkId;
  int? branchId;

  int? deliveryCustomerAddressId;
  int? deliveryPaymentTypeId;

  int? deliveryStatusTypeId;

  DateTime? deliveryDate;
  int? deliveryCustomerId;
  DeliveryModel({
    this.branchId,
    this.checkId,
    this.deliveryCustomerAddressId,
    this.deliveryDate,
    this.deliveryId,
    this.deliveryPaymentTypeId,
    this.deliveryStatusTypeId,
    this.deliveryCustomerId,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return _$DeliveryModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DeliveryModelToJson(this);
  }
}

@JsonSerializable()
class DeliveryListItem {
  String? customerFullName;
  String? customerPhoneNumber;
  String? address;
  String? addressDefinition;
  String? getirId;
  int? fuudyId;
  String? yemeksepetiId;
  String? region;
  double? amount;
  DateTime? createDate;
  String? integrationPaymentString;

  DateTime? deliveryDate;
  int? checkId;
  int? deliveryPaymentTypeId;
  int? deliveryStatusTypeId;
  int? deliverySourceTypeId;

  int? getirPaymentMethodTypeId;
  int? yemeksepetiPaymentMethodTypeId;
  int? getirStatus;
  int? yemeksepetiStatus;
  bool? isTakeAway;
  bool? isScheduled;
  bool? getirGetirsin;
  CourierModel? courier;
  DeliveryListItem({
    this.address,
    this.addressDefinition,
    this.amount,
    this.createDate,
    this.customerFullName,
    this.customerPhoneNumber,
    this.deliveryDate,
    this.deliveryPaymentTypeId,
    this.checkId,
    this.deliveryStatusTypeId,
    this.deliverySourceTypeId,
    this.getirId,
    this.getirPaymentMethodTypeId,
    this.isScheduled,
    this.isTakeAway,
    this.getirStatus,
    this.yemeksepetiId,
    this.yemeksepetiPaymentMethodTypeId,
    this.yemeksepetiStatus,
    this.integrationPaymentString,
    this.region,
    this.getirGetirsin,
    this.fuudyId,
    this.courier,
  });

  factory DeliveryListItem.fromJson(Map<String, dynamic> json) {
    return _$DeliveryListItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DeliveryListItemToJson(this);
  }
}

@JsonSerializable()
class DeliveryCustomerModel {
  int? deliveryCustomerId;
  String? name;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  List<DeliveryCustomerAddressModel>? deliveryCustomerAddresses;
  int? brandId;

  DeliveryCustomerModel({
    this.brandId,
    this.countryCode,
    this.deliveryCustomerAddresses,
    this.deliveryCustomerId,
    this.lastName,
    this.name,
    this.phoneNumber,
  });

  factory DeliveryCustomerModel.fromJson(Map<String, dynamic> json) {
    return _$DeliveryCustomerModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DeliveryCustomerModelToJson(this);
  }
}

@JsonSerializable()
class DeliveryCustomerTableRowModel {
  int? deliveryCustomerId;
  String? name;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  int? brandId;
  int? deliveryCustomerAddressId;
  String? addressTitle;
  String? address;
  String? fullName;

  DeliveryCustomerTableRowModel({
    this.brandId,
    this.countryCode,
    this.deliveryCustomerId,
    this.lastName,
    this.name,
    this.phoneNumber,
    this.address,
    this.addressTitle,
    this.deliveryCustomerAddressId,
    this.fullName,
  });

  factory DeliveryCustomerTableRowModel.fromJson(Map<String, dynamic> json) {
    return _$DeliveryCustomerTableRowModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DeliveryCustomerTableRowModelToJson(this);
  }
}

@JsonSerializable()
class DeliveryCustomerAddressModel {
  int? deliveryCustomerAddressId;

  int? deliveryCustomerId;
  String? address;
  String? addressDefinition;
  String? addressTitle;

  DeliveryCustomerAddressModel({
    this.address,
    this.addressDefinition,
    this.addressTitle,
    this.deliveryCustomerAddressId,
    this.deliveryCustomerId,
  });

  factory DeliveryCustomerAddressModel.fromJson(Map<String, dynamic> json) {
    return _$DeliveryCustomerAddressModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DeliveryCustomerAddressModelToJson(this);
  }
}

@JsonSerializable()
class CourierModel {
  int? branchId;

  int? courierId;
  String? courierName;

  CourierModel({
    this.branchId,
    this.courierId,
    this.courierName,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) {
    return _$CourierModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CourierModelToJson(this);
  }
}
