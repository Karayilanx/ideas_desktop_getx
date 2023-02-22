import 'package:json_annotation/json_annotation.dart';

import 'check_model.dart';
part 'yemeksepeti_model.g.dart';

@JsonSerializable()
class YemeksepetiCheckDetailsModel {
  int? checkId;
  int? status;
  DateTime? createDate;
  DateTime? deliveryDate;
  bool? isScheduled;
  List<CheckMenuItemModel>? basketItems;
  CheckPaymentsModel? payments;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? customerAddressDefinition;
  bool? vale;
  int? yemeksepetiPaymentTypeId;
  int? deliveryPaymentTypeId;
  int? deliveryStatusTypeId;
  String? checkNote;
  String? paymentTypeString;
  YemeksepetiCheckDetailsModel({
    this.checkId,
    this.status,
    this.createDate,
    this.deliveryDate,
    this.isScheduled,
    this.basketItems,
    this.payments,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
    this.customerAddressDefinition,
    this.vale,
    this.yemeksepetiPaymentTypeId,
    this.checkNote,
    this.paymentTypeString,
    this.deliveryPaymentTypeId,
    this.deliveryStatusTypeId,
  });

  factory YemeksepetiCheckDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$YemeksepetiCheckDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$YemeksepetiCheckDetailsModelToJson(this);
  }
}

@JsonSerializable()
class YemeksepetiRejectReason {
  int? reasonId;
  String? reasonName;

  YemeksepetiRejectReason({this.reasonId, this.reasonName});

  @override
  factory YemeksepetiRejectReason.fromJson(Map<String, dynamic> json) {
    return _$YemeksepetiRejectReasonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$YemeksepetiRejectReasonToJson(this);
  }
}

@JsonSerializable()
class YemeksepetiRestaurantModel {
  String? catalogName;
  String? categoryName;
  String? displayName;
  int? serviceTime;
  String? yemeksepetiRestaurantId;
  bool? isVale;

  YemeksepetiRestaurantModel({
    this.catalogName,
    this.categoryName,
    this.displayName,
    this.serviceTime,
    this.yemeksepetiRestaurantId,
    this.isVale,
  });

  factory YemeksepetiRestaurantModel.fromJson(Map<String, dynamic> json) {
    return _$YemeksepetiRestaurantModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$YemeksepetiRestaurantModelToJson(this);
  }
}
