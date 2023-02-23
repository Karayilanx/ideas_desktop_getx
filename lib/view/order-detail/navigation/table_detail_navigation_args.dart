import 'package:ideas_desktop_getx/model/delivery_model.dart';

import '../model/order_detail_model.dart';

class TableDetailArguments {
  final int? tableId;
  final int? checkId;
  final String? alias;
  final OrderDetailPageType type;
  final bool isIntegration;
  TableDetailArguments({
    required this.tableId,
    this.alias,
    required this.checkId,
    required this.type,
    required this.isIntegration,
  });
}

class DeliveryOrderDetailArguments {
  final int checkId;
  DeliveryOrderDetailArguments({
    required this.checkId,
  });
}

class DeliveryDetailSelectionArguments {
  final DeliveryModel delivery;
  final DeliveryCustomerModel selectedCustomer;
  DeliveryDetailSelectionArguments({
    required this.delivery,
    required this.selectedCustomer,
  });
}
