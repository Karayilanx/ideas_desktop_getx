import 'package:json_annotation/json_annotation.dart';
import 'check_model.dart';
part 'getir_model.g.dart';

@JsonSerializable()
class GetirCheckDetailsModel {
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
  bool? getirGetirsin;
  int? getirPaymentTypeId;
  int? deliveryPaymentTypeId;
  int? deliveryStatusTypeId;
  String? paymentTypeString;
  String? checkNote;

  GetirCheckDetailsModel({
    this.checkId,
    this.status,
    this.createDate,
    this.deliveryDate,
    this.isScheduled,
    this.basketItems,
    this.payments,
    this.customerAddress,
    this.customerAddressDefinition,
    this.customerName,
    this.customerPhoneNumber,
    this.getirGetirsin,
    this.getirPaymentTypeId,
    this.paymentTypeString,
    this.deliveryPaymentTypeId,
    this.deliveryStatusTypeId,
    this.checkNote,
  });

  factory GetirCheckDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$GetirCheckDetailsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetirCheckDetailsModelToJson(this);
  }
}

@JsonSerializable()
class GetirResultOutput {
  bool? result;
  GetirResultOutput({
    this.result,
  });

  factory GetirResultOutput.fromJson(Map<String, dynamic> json) {
    return _$GetirResultOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetirResultOutputToJson(this);
  }
}

@JsonSerializable()
class GetirCancelOption {
  String? id;
  String? message;
  GetirCancelOption({
    this.id,
    this.message,
  });

  factory GetirCancelOption.fromJson(Map<String, dynamic> json) {
    return _$GetirCancelOptionFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetirCancelOptionToJson(this);
  }
}

@JsonSerializable()
class GetirRestaurantStatusModel {
  String? restaurantId;
  String? restaurantName;
  int? averagePreparationTime;
  int? restaurantStatus;
  bool? isCourierAvailable;

  GetirRestaurantStatusModel({
    this.averagePreparationTime,
    this.isCourierAvailable,
    this.restaurantId,
    this.restaurantName,
    this.restaurantStatus,
  });

  factory GetirRestaurantStatusModel.fromJson(Map<String, dynamic> json) {
    return _$GetirRestaurantStatusModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetirRestaurantStatusModelToJson(this);
  }
}
