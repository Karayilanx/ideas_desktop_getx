// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

import '../../model/delivery_model.dart';

class DeliveryStore extends GetxController {
  RxList<DeliveryListItem> _deliveries = RxList<DeliveryListItem>([]);
  RxList<String> _calls = RxList<String>([]);

  void setDeliveries(List<DeliveryListItem> del) {
    _deliveries.clear();
    _deliveries(del);
  }

  void addCall(String del) {
    _calls.add(del);
    _calls = _calls;
  }

  RxList<DeliveryListItem> get deliveries => _deliveries;
}
