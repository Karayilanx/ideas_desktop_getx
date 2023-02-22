// ignore_for_file: constant_identifier_names

import 'menu_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'delivery_model.dart';
import 'table_model.dart';
part 'check_model.g.dart';

enum CheckPaymentTypeEnum { Cash, CreditCart, Discount, Unpayable, Gift, Other }

enum CheckStatusTypeEnum { Active, BillSent, Closed }

enum CheckMenuItemActionType { ORDER, GIFT, CANCEL, PAID }

extension ActionTypeExtension on CheckMenuItemActionType {
  int get getValue {
    switch (this) {
      case CheckMenuItemActionType.ORDER:
        return 0;
      case CheckMenuItemActionType.GIFT:
        return 1;
      case CheckMenuItemActionType.CANCEL:
        return 2;
      case CheckMenuItemActionType.PAID:
        return 3;
      default:
        throw 'ERROR TYPE';
    }
  }
}

@JsonSerializable()
class CheckDetailsModel {
  int? checkId;
  int? branchId;
  int? tableId;
  String? alias;
  List<CheckMenuItemModel?>? basketItems;
  DateTime? createDate;
  DateTime? closeDate;
  int? terminalUserId;
  DeliveryModel? delivery;
  CheckPaymentsModel? payments;
  TableWithDetails? table;
  String? terminalUsername;
  String? checkNote;
  double? constantDiscountPercentage;
  double? spendingLimit;
  int? checkStatusTypeId;
  CheckDetailCheckAccountTransaction? checkAccountTransaction;
  int? checkAccountId;
  String? checkAccountName;
  int? personCount;
  int? endOfDayId;
  bool? printOrders;
  CheckDetailsModel({
    this.alias,
    this.basketItems,
    this.checkId,
    this.createDate,
    this.delivery,
    this.payments,
    this.tableId,
    this.terminalUserId,
    this.table,
    this.terminalUsername,
    this.branchId,
    this.checkAccountTransaction,
    this.checkNote,
    this.constantDiscountPercentage,
    this.spendingLimit,
    this.checkStatusTypeId,
    this.checkAccountId,
    this.checkAccountName,
    this.personCount,
    this.endOfDayId,
    this.closeDate,
    this.printOrders,
  });

  factory CheckDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$CheckDetailsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckDetailsModelToJson(this);
  }
}

@JsonSerializable()
class PaymentCheckAccountDetailModel {
  int? checkAccountId;
  String? checkAcccountName;
  double? amount;
  int? checkPaymentTypeId;

  PaymentCheckAccountDetailModel(
    this.checkAccountId,
    this.checkAcccountName,
    this.amount,
    this.checkPaymentTypeId,
  );

  factory PaymentCheckAccountDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentCheckAccountDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCheckAccountDetailModelToJson(this);
}

@JsonSerializable()
class CheckPaymentsModel {
  double? checkAmount;
  double? discountAmount;
  double? totalPaymentAmount;
  double? remainingAmount;
  double? unpayableAmount;
  double? paymentsWithoutDiscountsAmount;
  double? cashAmount;
  double? creditCardAmount;
  double? serviceChargeAmount;
  List<PaymentCheckAccountDetailModel>? paymentDetails;
  CheckPaymentsModel({
    this.checkAmount,
    this.discountAmount,
    this.paymentsWithoutDiscountsAmount,
    this.remainingAmount,
    this.totalPaymentAmount,
    this.unpayableAmount,
    this.cashAmount,
    this.creditCardAmount,
    this.serviceChargeAmount,
    this.paymentDetails,
  });

  factory CheckPaymentsModel.fromJson(Map<String, dynamic> json) {
    return _$CheckPaymentsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckPaymentsModelToJson(this);
  }
}

@JsonSerializable()
class CheckPaymentModel {
  int? checkId;
  int? paymentTypeId;
  double? amount;
  DateTime? createDate;
  int? terminalUserId;
  bool? isMenuItemBased;
  int? checkAccountId;
  String? printerName;
  int branchId;

  List<CheckMenuItemModel?>? checkMenuItems;

  CheckPaymentModel({
    this.amount,
    this.checkId,
    this.checkMenuItems,
    this.createDate,
    this.isMenuItemBased,
    this.paymentTypeId,
    this.terminalUserId,
    this.checkAccountId,
    this.printerName,
    required this.branchId,
  });

  @override
  factory CheckPaymentModel.fromJson(Map<String, dynamic> json) {
    return _$CheckPaymentModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckPaymentModelToJson(this);
  }
}

@JsonSerializable()
class CheckMenuItemModel {
  int? checkMenuItemId;
  int? menuItemId;
  double totalPrice;
  String? name;
  double? sellUnitQuantity;
  String? note;
  List<CondimentModel>? condiments;
  @JsonKey(defaultValue: false)
  bool? isStopped;
  int? actionType;
  int? basketGroupId;
  DefaultSellUnitModel? sellUnit;
  int? printerId;
  String get getName => _getName();

  CheckMenuItemModel({
    this.condiments,
    this.menuItemId,
    this.name,
    this.note,
    this.actionType,
    required this.totalPrice,
    this.sellUnitQuantity,
    this.sellUnit,
    this.isStopped = false,
    this.basketGroupId,
    this.printerId,
    this.checkMenuItemId,
  });

  factory CheckMenuItemModel.fromJson(Map<String, dynamic> json) {
    return _$CheckMenuItemModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckMenuItemModelToJson(this);
  }

  bool isSame(CheckMenuItemModel item) {
    if (item.menuItemId == menuItemId &&
        item.name == name &&
        item.totalPrice == totalPrice &&
        item.condiments!.length == condiments!.length &&
        isStopped == item.isStopped &&
        sellUnitQuantity == item.sellUnitQuantity &&
        actionType == item.actionType &&
        isNotesSame(item) &&
        isCondimentsSame(item)) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotesSame(CheckMenuItemModel item) {
    item.note ??= '';
    note ??= '';
    return (note == item.note);
  }

  bool isCondimentsSame(CheckMenuItemModel item) {
    if (item.condiments!.length == condiments!.length) {
      for (var itemCondiment in item.condiments!) {
        bool found = false;
        for (var condiment in condiments!) {
          if (condiment.condimentId == itemCondiment.condimentId &&
              condiment.condimentGroupId == itemCondiment.condimentGroupId) {
            found = true;
            break;
          }
        }
        if (!found) return false;
      }
    }
    return true;
  }

  String _getName() {
    String nameString = "";
    nameString = sellUnitQuantity != 1
        ? "${sellUnitQuantity!.toStringAsFixed(sellUnitQuantity! % 1 == 0 ? 0 : sellUnit!.defaultSellUnitId! == 1 ? 1 : 3)} "
        : "";
    nameString += name!;
    return nameString;
  }
}

@JsonSerializable()
class CondimentModel {
  int? condimentId;
  double price;
  String? nameTr;
  String? nameEn;
  int? condimentGroupId;
  int? menuItemId;
  String? condimentGroupName;
  int? parentBasketGroupId;
  int? basketGroupId;
  bool? isIngredient;
  CondimentModel({
    this.condimentGroupId,
    this.condimentId,
    this.nameEn,
    this.nameTr,
    this.menuItemId,
    this.condimentGroupName,
    this.parentBasketGroupId,
    this.basketGroupId,
    this.isIngredient,
    required this.price,
  });

  factory CondimentModel.fromJson(Map<String, dynamic> json) {
    return _$CondimentModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CondimentModelToJson(this);
  }
}

@JsonSerializable()
class GroupedCheckItem {
  String? name;
  double totalPrice;
  double? sellUnitQuantity;
  int? itemCount;
  CheckMenuItemModel? originalItem;
  List<int>? checkMenuItemIds;
  String get getName => _getName();

  GroupedCheckItem({
    this.name,
    this.originalItem,
    this.sellUnitQuantity,
    this.itemCount,
    this.checkMenuItemIds,
    required this.totalPrice,
  });

  factory GroupedCheckItem.fromJson(Map<String, dynamic> json) {
    return _$GroupedCheckItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GroupedCheckItemToJson(this);
  }

  String _getName() {
    String nameString = "";
    nameString = sellUnitQuantity != 1
        ? "${sellUnitQuantity!.toStringAsFixed(originalItem!.sellUnitQuantity! % 1 == 0 ? 0 : originalItem!.sellUnit!.defaultSellUnitId! == 1 ? 1 : 3)} "
        : "";
    nameString += name!;
    return nameString;
  }

  String getCondimentNames() {
    String ret = '';
    String groupName = '';
    for (var condiment in originalItem!.condiments!) {
      if (condiment.condimentGroupName != null &&
          groupName != condiment.condimentGroupName) {
        groupName = condiment.condimentGroupName!;
        if (ret.isNotEmpty) {
          ret = ret.substring(0, ret.length - 2);
          ret += "\n<b>$groupName:</b> ";
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          ret += '<b>' + groupName + ":</b>  ";
        }
      }
      ret += "${condiment.nameTr!}, ";
    }
    if (ret.length > 2) {
      ret = ret.substring(0, ret.length - 2);
    }
    return ret;
  }

  String getCondimentNamesAndNote() {
    String res = getCondimentNames();
    if (originalItem!.note != null && originalItem!.note != '') {
      if (res.isNotEmpty) res += '\nNot: ';
      res += originalItem!.note!;
    }

    return res;
  }
}

@JsonSerializable()
class CancelCheckItemInput {
  GroupedCheckItem? groupedCheckItem;
  int? cancelQuantity;
  int? checkId;
  int? terminalUserId;
  int? cancelTypeId;
  String? cancelNote;
  bool? saveNote;
  int branchId;
  CancelCheckItemInput({
    this.checkId,
    this.groupedCheckItem,
    this.cancelQuantity,
    this.terminalUserId,
    this.cancelTypeId,
    this.cancelNote,
    this.saveNote,
    required this.branchId,
  });

  factory CancelCheckItemInput.fromJson(Map<String, dynamic> json) {
    return _$CancelCheckItemInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CancelCheckItemInputToJson(this);
  }
}

@JsonSerializable()
class TransferOrdersInput {
  List<CheckMenuItemModel?>? checkMenuItems;
  int? targetTableId;
  String? alias;
  int? checkId;
  int? targetCheckId;
  int? terminalUserId;
  bool transferAll;
  int branchId;
  TransferOrdersInput({
    this.alias,
    this.checkId,
    this.checkMenuItems,
    this.targetCheckId,
    this.targetTableId,
    this.terminalUserId,
    required this.transferAll,
    required this.branchId,
  });

  factory TransferOrdersInput.fromJson(Map<String, dynamic> json) {
    return _$TransferOrdersInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$TransferOrdersInputToJson(this);
  }
}

@JsonSerializable()
class CheckPaymentResultOutput {
  int? checkPaymentId;
  double? paidAmount;
  double? changeAmount;
  int? checkStatusTypeId;

  CheckPaymentResultOutput(
      {this.changeAmount,
      this.checkPaymentId,
      this.checkStatusTypeId,
      this.paidAmount});

  @override
  factory CheckPaymentResultOutput.fromJson(Map<String, dynamic> json) {
    return _$CheckPaymentResultOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckPaymentResultOutputToJson(this);
  }
}

@JsonSerializable()
class ClosedCheckListItem {
  int? checkId;
  String? checkName;
  double? checkAmount;
  int? checkTypeId;
  DateTime? openDate;

  DateTime? closeDate;
  ClosedCheckListItem({
    this.checkId,
    this.checkName,
    this.checkAmount,
    this.checkTypeId,
    this.openDate,
    this.closeDate,
  });

  factory ClosedCheckListItem.fromJson(Map<String, dynamic> json) {
    return _$ClosedCheckListItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$ClosedCheckListItemToJson(this);
  }
}

@JsonSerializable()
class CheckDetailCheckAccountTransaction {
  DateTime? transactionDate;
  int? checkAccountId;
  String? checkAccountName;
  CheckDetailCheckAccountTransaction({
    this.transactionDate,
    this.checkAccountId,
    this.checkAccountName,
  });

  factory CheckDetailCheckAccountTransaction.fromJson(
      Map<String, Object> json) {
    return _$CheckDetailCheckAccountTransactionFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckDetailCheckAccountTransactionToJson(this);
  }
}

@JsonSerializable()
class UpdateCheckNoteInput {
  int checkId;
  String checkNote;
  int terminalUserId;
  int branchId;
  UpdateCheckNoteInput({
    required this.checkId,
    required this.checkNote,
    required this.terminalUserId,
    required this.branchId,
  });

  factory UpdateCheckNoteInput.fromJson(Map<String, Object> json) {
    return _$UpdateCheckNoteInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$UpdateCheckNoteInputToJson(this);
  }
}

@JsonSerializable()
class CancelRequestRow {
  int? checkMenuItemCancelRequestRowId;
  int? checkMenuItemId;
  CancelRequestRow({
    this.checkMenuItemCancelRequestRowId,
    this.checkMenuItemId,
  });

  factory CancelRequestRow.fromJson(Map<String, Object> json) {
    return _$CancelRequestRowFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CancelRequestRowToJson(this);
  }
}

@JsonSerializable()
class CancelRequest {
  int? checkMenuItemCancelRequestId;
  int? terminalUserId;
  String? terminalUserName;
  List<CancelRequestRow>? rows;
  int? checkId;
  DateTime? createDate;
  String? note;
  int? cancelTypeId;
  String? name;

  CancelRequest({
    this.checkMenuItemCancelRequestId,
    this.rows,
    this.terminalUserId,
    this.terminalUserName,
    this.checkId,
    this.createDate,
    this.note,
    this.cancelTypeId,
    this.name,
  });

  factory CancelRequest.fromJson(Map<String, Object> json) {
    return _$CancelRequestFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CancelRequestToJson(this);
  }
}

@JsonSerializable()
class RequestsModel {
  List<CancelRequest>? cancelRequests;
  List<QrRequestModel>? qrRequests;
  RequestsModel({
    this.cancelRequests,
    this.qrRequests,
  });

  factory RequestsModel.fromJson(Map<String, Object> json) {
    return _$RequestsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$RequestsModelToJson(this);
  }
}

@JsonSerializable()
class QrRequestModel {
  int? branchId;
  int? tableId;
  String? tableName;
  int? qrCheckId;
  String? type;
  DateTime? createDate;

  QrRequestModel({
    this.branchId,
    this.createDate,
    this.qrCheckId,
    this.tableId,
    this.tableName,
    this.type,
  });

  factory QrRequestModel.fromJson(Map<String, Object?> json) {
    return _$QrRequestModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$QrRequestModelToJson(this);
  }
}

@JsonSerializable()
class QrCheckDetailsModel {
  int? qrCheckId;
  int? tableId;
  String? tableName;
  double? amount;
  int? branchId;
  List<CheckMenuItemModel>? basketItems;
  DateTime? createDate;
  String? checkNote;
  int? qrCheckStatusId;

  QrCheckDetailsModel(
      {this.amount,
      this.basketItems,
      this.branchId,
      this.checkNote,
      this.createDate,
      this.qrCheckId,
      this.qrCheckStatusId,
      this.tableId,
      this.tableName});

  @override
  factory QrCheckDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$QrCheckDetailsModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$QrCheckDetailsModelToJson(this);
  }
}

@JsonSerializable()
class ChangePriceModel {
  List<int>? checkMenuItemIds;
  int? branchId;
  int? terminalUserId;
  int? checkId;
  double? totalPrice;

  ChangePriceModel({
    this.branchId,
    this.checkId,
    this.checkMenuItemIds,
    this.totalPrice,
    this.terminalUserId,
  });

  factory ChangePriceModel.fromJson(Map<String, Object> json) {
    return _$ChangePriceModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$ChangePriceModelToJson(this);
  }
}

@JsonSerializable()
class CheckLogModel {
  int? checkLogId;
  DateTime? createDate;
  String? logType;
  String? info;
  String? terminalUserName;
  int? terminalUserId;
  CheckLogModel({
    this.checkLogId,
    this.createDate,
    this.info,
    this.logType,
    this.terminalUserId,
    this.terminalUserName,
  });

  @override
  factory CheckLogModel.fromJson(Map<String, dynamic> json) {
    return _$CheckLogModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CheckLogModelToJson(this);
  }
}

@JsonSerializable()
class OrderLogModel {
  int? branchId;
  int? orderNo;
  String? terminalUserName;
  int? terminalUserId;
  DateTime? createDate;
  int? menuItemId;
  String? menuItemName;
  double? sellUnitQuantity;
  double? totalPrice;
  String? orderType;

  OrderLogModel({
    this.createDate,
    this.terminalUserId,
    this.terminalUserName,
    this.branchId,
    this.menuItemId,
    this.menuItemName,
    this.orderNo,
    this.orderType,
    this.sellUnitQuantity,
    this.totalPrice,
  });

  factory OrderLogModel.fromJson(Map<String, Object> json) {
    return _$OrderLogModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$OrderLogModelToJson(this);
  }
}
