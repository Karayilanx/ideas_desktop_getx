import 'package:json_annotation/json_annotation.dart';
import 'check_model.dart';
part 'fuudy_model.g.dart';

@JsonSerializable()
class FuudyCheckDetailsModel {
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
  bool? isRestaurantCourier;
  int? deliveryPaymentTypeId;
  int? deliveryStatusTypeId;
  String? paymentTypeString;
  String? checkNote;

  FuudyCheckDetailsModel({
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
    this.isRestaurantCourier,
    this.paymentTypeString,
    this.deliveryPaymentTypeId,
    this.deliveryStatusTypeId,
    this.checkNote,
  });

  factory FuudyCheckDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$FuudyCheckDetailsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$FuudyCheckDetailsModelToJson(this);
  }
}
