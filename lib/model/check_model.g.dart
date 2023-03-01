// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckDetailsModel _$CheckDetailsModelFromJson(Map<String, dynamic> json) =>
    CheckDetailsModel(
      alias: json['alias'] as String?,
      basketItems: (json['basketItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkId: json['checkId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      delivery: json['delivery'] == null
          ? null
          : DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>),
      payments: json['payments'] == null
          ? null
          : CheckPaymentsModel.fromJson(
              json['payments'] as Map<String, dynamic>),
      tableId: json['tableId'] as int?,
      terminalUserId: json['terminalUserId'] as int?,
      table: json['table'] == null
          ? null
          : TableWithDetails.fromJson(json['table'] as Map<String, dynamic>),
      terminalUsername: json['terminalUsername'] as String?,
      branchId: json['branchId'] as int?,
      checkAccountTransaction: json['checkAccountTransaction'] == null
          ? null
          : CheckDetailCheckAccountTransaction.fromJson(
              json['checkAccountTransaction'] as Map<String, dynamic>),
      checkNote: json['checkNote'] as String?,
      constantDiscountPercentage:
          (json['constantDiscountPercentage'] as num?)?.toDouble(),
      spendingLimit: (json['spendingLimit'] as num?)?.toDouble(),
      checkStatusTypeId: json['checkStatusTypeId'] as int?,
      checkAccountId: json['checkAccountId'] as int?,
      checkAccountName: json['checkAccountName'] as String?,
      personCount: json['personCount'] as int?,
      endOfDayId: json['endOfDayId'] as int?,
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.parse(json['closeDate'] as String),
      printOrders: json['printOrders'] as bool?,
    );

Map<String, dynamic> _$CheckDetailsModelToJson(CheckDetailsModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'branchId': instance.branchId,
      'tableId': instance.tableId,
      'alias': instance.alias,
      'basketItems': instance.basketItems,
      'createDate': instance.createDate?.toIso8601String(),
      'closeDate': instance.closeDate?.toIso8601String(),
      'terminalUserId': instance.terminalUserId,
      'delivery': instance.delivery,
      'payments': instance.payments,
      'table': instance.table,
      'terminalUsername': instance.terminalUsername,
      'checkNote': instance.checkNote,
      'constantDiscountPercentage': instance.constantDiscountPercentage,
      'spendingLimit': instance.spendingLimit,
      'checkStatusTypeId': instance.checkStatusTypeId,
      'checkAccountTransaction': instance.checkAccountTransaction,
      'checkAccountId': instance.checkAccountId,
      'checkAccountName': instance.checkAccountName,
      'personCount': instance.personCount,
      'endOfDayId': instance.endOfDayId,
      'printOrders': instance.printOrders,
    };

PaymentCheckAccountDetailModel _$PaymentCheckAccountDetailModelFromJson(
        Map<String, dynamic> json) =>
    PaymentCheckAccountDetailModel(
      json['checkAccountId'] as int?,
      json['checkAcccountName'] as String?,
      (json['amount'] as num?)?.toDouble(),
      json['checkPaymentTypeId'] as int?,
    );

Map<String, dynamic> _$PaymentCheckAccountDetailModelToJson(
        PaymentCheckAccountDetailModel instance) =>
    <String, dynamic>{
      'checkAccountId': instance.checkAccountId,
      'checkAcccountName': instance.checkAcccountName,
      'amount': instance.amount,
      'checkPaymentTypeId': instance.checkPaymentTypeId,
    };

CheckPaymentsModel _$CheckPaymentsModelFromJson(Map<String, dynamic> json) =>
    CheckPaymentsModel(
      checkAmount: (json['checkAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      paymentsWithoutDiscountsAmount:
          (json['paymentsWithoutDiscountsAmount'] as num?)?.toDouble(),
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble(),
      totalPaymentAmount: (json['totalPaymentAmount'] as num?)?.toDouble(),
      unpayableAmount: (json['unpayableAmount'] as num?)?.toDouble(),
      cashAmount: (json['cashAmount'] as num?)?.toDouble(),
      creditCardAmount: (json['creditCardAmount'] as num?)?.toDouble(),
      serviceChargeAmount: (json['serviceChargeAmount'] as num?)?.toDouble(),
      paymentDetails: (json['paymentDetails'] as List<dynamic>?)
          ?.map((e) => PaymentCheckAccountDetailModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckPaymentsModelToJson(CheckPaymentsModel instance) =>
    <String, dynamic>{
      'checkAmount': instance.checkAmount,
      'discountAmount': instance.discountAmount,
      'totalPaymentAmount': instance.totalPaymentAmount,
      'remainingAmount': instance.remainingAmount,
      'unpayableAmount': instance.unpayableAmount,
      'paymentsWithoutDiscountsAmount': instance.paymentsWithoutDiscountsAmount,
      'cashAmount': instance.cashAmount,
      'creditCardAmount': instance.creditCardAmount,
      'serviceChargeAmount': instance.serviceChargeAmount,
      'paymentDetails': instance.paymentDetails,
    };

CheckPaymentModel _$CheckPaymentModelFromJson(Map<String, dynamic> json) =>
    CheckPaymentModel(
      amount: (json['amount'] as num?)?.toDouble(),
      checkId: json['checkId'] as int?,
      checkMenuItems: (json['checkMenuItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      isMenuItemBased: json['isMenuItemBased'] as bool?,
      paymentTypeId: json['paymentTypeId'] as int?,
      terminalUserId: json['terminalUserId'] as int?,
      checkAccountId: json['checkAccountId'] as int?,
      printerName: json['printerName'] as String?,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$CheckPaymentModelToJson(CheckPaymentModel instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'paymentTypeId': instance.paymentTypeId,
      'amount': instance.amount,
      'createDate': instance.createDate?.toIso8601String(),
      'terminalUserId': instance.terminalUserId,
      'isMenuItemBased': instance.isMenuItemBased,
      'checkAccountId': instance.checkAccountId,
      'printerName': instance.printerName,
      'branchId': instance.branchId,
      'checkMenuItems': instance.checkMenuItems,
    };

CheckMenuItemModel _$CheckMenuItemModelFromJson(Map<String, dynamic> json) =>
    CheckMenuItemModel(
      condiments: (json['condiments'] as List<dynamic>?)
          ?.map((e) => CondimentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      menuItemId: json['menuItemId'] as int?,
      name: json['name'] as String?,
      note: json['note'] as String?,
      actionType: json['actionType'] as int?,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      sellUnitQuantity: (json['sellUnitQuantity'] as num?)?.toDouble(),
      sellUnit: json['sellUnit'] == null
          ? null
          : DefaultSellUnitModel.fromJson(
              json['sellUnit'] as Map<String, dynamic>),
      isStopped: json['isStopped'] as bool? ?? false,
      basketGroupId: json['basketGroupId'] as int?,
      printerId: json['printerId'] as int?,
      checkMenuItemId: json['checkMenuItemId'] as int?,
    );

Map<String, dynamic> _$CheckMenuItemModelToJson(CheckMenuItemModel instance) =>
    <String, dynamic>{
      'checkMenuItemId': instance.checkMenuItemId,
      'menuItemId': instance.menuItemId,
      'totalPrice': instance.totalPrice,
      'name': instance.name,
      'sellUnitQuantity': instance.sellUnitQuantity,
      'note': instance.note,
      'condiments': instance.condiments,
      'isStopped': instance.isStopped,
      'actionType': instance.actionType,
      'basketGroupId': instance.basketGroupId,
      'sellUnit': instance.sellUnit,
      'printerId': instance.printerId,
    };

CondimentModel _$CondimentModelFromJson(Map<String, dynamic> json) =>
    CondimentModel(
      condimentGroupId: json['condimentGroupId'] as int?,
      condimentId: json['condimentId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      menuItemId: json['menuItemId'] as int?,
      condimentGroupName: json['condimentGroupName'] as String?,
      parentBasketGroupId: json['parentBasketGroupId'] as int?,
      basketGroupId: json['basketGroupId'] as int?,
      isIngredient: json['isIngredient'] as bool?,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CondimentModelToJson(CondimentModel instance) =>
    <String, dynamic>{
      'condimentId': instance.condimentId,
      'price': instance.price,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'condimentGroupId': instance.condimentGroupId,
      'menuItemId': instance.menuItemId,
      'condimentGroupName': instance.condimentGroupName,
      'parentBasketGroupId': instance.parentBasketGroupId,
      'basketGroupId': instance.basketGroupId,
      'isIngredient': instance.isIngredient,
    };

GroupedCheckItem _$GroupedCheckItemFromJson(Map<String, dynamic> json) =>
    GroupedCheckItem(
      name: json['name'] as String?,
      originalItem: json['originalItem'] == null
          ? null
          : CheckMenuItemModel.fromJson(
              json['originalItem'] as Map<String, dynamic>),
      sellUnitQuantity: (json['sellUnitQuantity'] as num?)?.toDouble(),
      itemCount: json['itemCount'] as int?,
      checkMenuItemIds: (json['checkMenuItemIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$GroupedCheckItemToJson(GroupedCheckItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalPrice': instance.totalPrice,
      'sellUnitQuantity': instance.sellUnitQuantity,
      'itemCount': instance.itemCount,
      'originalItem': instance.originalItem,
      'checkMenuItemIds': instance.checkMenuItemIds,
    };

CancelCheckItemInput _$CancelCheckItemInputFromJson(
        Map<String, dynamic> json) =>
    CancelCheckItemInput(
      checkId: json['checkId'] as int?,
      groupedCheckItem: json['groupedCheckItem'] == null
          ? null
          : GroupedCheckItem.fromJson(
              json['groupedCheckItem'] as Map<String, dynamic>),
      cancelQuantity: json['cancelQuantity'] as int?,
      terminalUserId: json['terminalUserId'] as int?,
      cancelTypeId: json['cancelTypeId'] as int?,
      cancelNote: json['cancelNote'] as String?,
      saveNote: json['saveNote'] as bool?,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$CancelCheckItemInputToJson(
        CancelCheckItemInput instance) =>
    <String, dynamic>{
      'groupedCheckItem': instance.groupedCheckItem,
      'cancelQuantity': instance.cancelQuantity,
      'checkId': instance.checkId,
      'terminalUserId': instance.terminalUserId,
      'cancelTypeId': instance.cancelTypeId,
      'cancelNote': instance.cancelNote,
      'saveNote': instance.saveNote,
      'branchId': instance.branchId,
    };

TransferOrdersInput _$TransferOrdersInputFromJson(Map<String, dynamic> json) =>
    TransferOrdersInput(
      alias: json['alias'] as String?,
      checkId: json['checkId'] as int?,
      checkMenuItems: (json['checkMenuItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetCheckId: json['targetCheckId'] as int?,
      targetTableId: json['targetTableId'] as int?,
      terminalUserId: json['terminalUserId'] as int?,
      transferAll: json['transferAll'] as bool,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$TransferOrdersInputToJson(
        TransferOrdersInput instance) =>
    <String, dynamic>{
      'checkMenuItems': instance.checkMenuItems,
      'targetTableId': instance.targetTableId,
      'alias': instance.alias,
      'checkId': instance.checkId,
      'targetCheckId': instance.targetCheckId,
      'terminalUserId': instance.terminalUserId,
      'transferAll': instance.transferAll,
      'branchId': instance.branchId,
    };

CheckPaymentResultOutput _$CheckPaymentResultOutputFromJson(
        Map<String, dynamic> json) =>
    CheckPaymentResultOutput(
      changeAmount: (json['changeAmount'] as num?)?.toDouble(),
      checkPaymentId: json['checkPaymentId'] as int?,
      checkStatusTypeId: json['checkStatusTypeId'] as int?,
      paidAmount: (json['paidAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CheckPaymentResultOutputToJson(
        CheckPaymentResultOutput instance) =>
    <String, dynamic>{
      'checkPaymentId': instance.checkPaymentId,
      'paidAmount': instance.paidAmount,
      'changeAmount': instance.changeAmount,
      'checkStatusTypeId': instance.checkStatusTypeId,
    };

ClosedCheckListItem _$ClosedCheckListItemFromJson(Map<String, dynamic> json) =>
    ClosedCheckListItem(
      checkId: json['checkId'] as int?,
      checkName: json['checkName'] as String?,
      checkAmount: (json['checkAmount'] as num?)?.toDouble(),
      checkTypeId: json['checkTypeId'] as int?,
      openDate: json['openDate'] == null
          ? null
          : DateTime.parse(json['openDate'] as String),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.parse(json['closeDate'] as String),
    );

Map<String, dynamic> _$ClosedCheckListItemToJson(
        ClosedCheckListItem instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'checkName': instance.checkName,
      'checkAmount': instance.checkAmount,
      'checkTypeId': instance.checkTypeId,
      'openDate': instance.openDate?.toIso8601String(),
      'closeDate': instance.closeDate?.toIso8601String(),
    };

CheckDetailCheckAccountTransaction _$CheckDetailCheckAccountTransactionFromJson(
        Map<String, dynamic> json) =>
    CheckDetailCheckAccountTransaction(
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      checkAccountId: json['checkAccountId'] as int?,
      checkAccountName: json['checkAccountName'] as String?,
    );

Map<String, dynamic> _$CheckDetailCheckAccountTransactionToJson(
        CheckDetailCheckAccountTransaction instance) =>
    <String, dynamic>{
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'checkAccountId': instance.checkAccountId,
      'checkAccountName': instance.checkAccountName,
    };

UpdateCheckNoteInput _$UpdateCheckNoteInputFromJson(
        Map<String, dynamic> json) =>
    UpdateCheckNoteInput(
      checkId: json['checkId'] as int,
      checkNote: json['checkNote'] as String,
      terminalUserId: json['terminalUserId'] as int,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$UpdateCheckNoteInputToJson(
        UpdateCheckNoteInput instance) =>
    <String, dynamic>{
      'checkId': instance.checkId,
      'checkNote': instance.checkNote,
      'terminalUserId': instance.terminalUserId,
      'branchId': instance.branchId,
    };

CancelRequestRow _$CancelRequestRowFromJson(Map<String, dynamic> json) =>
    CancelRequestRow(
      checkMenuItemCancelRequestRowId:
          json['checkMenuItemCancelRequestRowId'] as int?,
      checkMenuItemId: json['checkMenuItemId'] as int?,
    );

Map<String, dynamic> _$CancelRequestRowToJson(CancelRequestRow instance) =>
    <String, dynamic>{
      'checkMenuItemCancelRequestRowId':
          instance.checkMenuItemCancelRequestRowId,
      'checkMenuItemId': instance.checkMenuItemId,
    };

CancelRequest _$CancelRequestFromJson(Map<String, dynamic> json) =>
    CancelRequest(
      checkMenuItemCancelRequestId:
          json['checkMenuItemCancelRequestId'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => CancelRequestRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      terminalUserId: json['terminalUserId'] as int?,
      terminalUserName: json['terminalUserName'] as String?,
      checkId: json['checkId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      note: json['note'] as String?,
      cancelTypeId: json['cancelTypeId'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CancelRequestToJson(CancelRequest instance) =>
    <String, dynamic>{
      'checkMenuItemCancelRequestId': instance.checkMenuItemCancelRequestId,
      'terminalUserId': instance.terminalUserId,
      'terminalUserName': instance.terminalUserName,
      'rows': instance.rows,
      'checkId': instance.checkId,
      'createDate': instance.createDate?.toIso8601String(),
      'note': instance.note,
      'cancelTypeId': instance.cancelTypeId,
      'name': instance.name,
    };

RequestsModel _$RequestsModelFromJson(Map<String, dynamic> json) =>
    RequestsModel(
      cancelRequests: (json['cancelRequests'] as List<dynamic>?)
          ?.map((e) => CancelRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      qrRequests: (json['qrRequests'] as List<dynamic>?)
          ?.map((e) => QrRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestsModelToJson(RequestsModel instance) =>
    <String, dynamic>{
      'cancelRequests': instance.cancelRequests,
      'qrRequests': instance.qrRequests,
    };

QrRequestModel _$QrRequestModelFromJson(Map<String, dynamic> json) =>
    QrRequestModel(
      branchId: json['branchId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      qrCheckId: json['qrCheckId'] as int?,
      tableId: json['tableId'] as int?,
      tableName: json['tableName'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$QrRequestModelToJson(QrRequestModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'tableId': instance.tableId,
      'tableName': instance.tableName,
      'qrCheckId': instance.qrCheckId,
      'type': instance.type,
      'createDate': instance.createDate?.toIso8601String(),
    };

QrCheckDetailsModel _$QrCheckDetailsModelFromJson(Map<String, dynamic> json) =>
    QrCheckDetailsModel(
      amount: (json['amount'] as num?)?.toDouble(),
      basketItems: (json['basketItems'] as List<dynamic>?)
          ?.map((e) => CheckMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchId: json['branchId'] as int?,
      checkNote: json['checkNote'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      qrCheckId: json['qrCheckId'] as int?,
      qrCheckStatusId: json['qrCheckStatusId'] as int?,
      tableId: json['tableId'] as int?,
      tableName: json['tableName'] as String?,
    );

Map<String, dynamic> _$QrCheckDetailsModelToJson(
        QrCheckDetailsModel instance) =>
    <String, dynamic>{
      'qrCheckId': instance.qrCheckId,
      'tableId': instance.tableId,
      'tableName': instance.tableName,
      'amount': instance.amount,
      'branchId': instance.branchId,
      'basketItems': instance.basketItems,
      'createDate': instance.createDate?.toIso8601String(),
      'checkNote': instance.checkNote,
      'qrCheckStatusId': instance.qrCheckStatusId,
    };

ChangePriceModel _$ChangePriceModelFromJson(Map<String, dynamic> json) =>
    ChangePriceModel(
      branchId: json['branchId'] as int?,
      checkId: json['checkId'] as int?,
      checkMenuItemIds: (json['checkMenuItemIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      terminalUserId: json['terminalUserId'] as int?,
    );

Map<String, dynamic> _$ChangePriceModelToJson(ChangePriceModel instance) =>
    <String, dynamic>{
      'checkMenuItemIds': instance.checkMenuItemIds,
      'branchId': instance.branchId,
      'terminalUserId': instance.terminalUserId,
      'checkId': instance.checkId,
      'totalPrice': instance.totalPrice,
    };

CheckLogModel _$CheckLogModelFromJson(Map<String, dynamic> json) =>
    CheckLogModel(
      checkLogId: json['checkLogId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      info: json['info'] as String?,
      logType: json['logType'] as String?,
      terminalUserId: json['terminalUserId'] as int?,
      terminalUserName: json['terminalUserName'] as String?,
    );

Map<String, dynamic> _$CheckLogModelToJson(CheckLogModel instance) =>
    <String, dynamic>{
      'checkLogId': instance.checkLogId,
      'createDate': instance.createDate?.toIso8601String(),
      'logType': instance.logType,
      'info': instance.info,
      'terminalUserName': instance.terminalUserName,
      'terminalUserId': instance.terminalUserId,
    };

OrderLogModel _$OrderLogModelFromJson(Map<String, dynamic> json) =>
    OrderLogModel(
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      terminalUserId: json['terminalUserId'] as int?,
      terminalUserName: json['terminalUserName'] as String?,
      branchId: json['branchId'] as int?,
      menuItemId: json['menuItemId'] as int?,
      menuItemName: json['menuItemName'] as String?,
      orderNo: json['orderNo'] as int?,
      orderType: json['orderType'] as String?,
      sellUnitQuantity: (json['sellUnitQuantity'] as num?)?.toDouble(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderLogModelToJson(OrderLogModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'orderNo': instance.orderNo,
      'terminalUserName': instance.terminalUserName,
      'terminalUserId': instance.terminalUserId,
      'createDate': instance.createDate?.toIso8601String(),
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'sellUnitQuantity': instance.sellUnitQuantity,
      'totalPrice': instance.totalPrice,
      'orderType': instance.orderType,
    };
