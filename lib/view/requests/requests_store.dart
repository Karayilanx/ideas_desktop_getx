import 'package:get/get.dart';

import '../../model/check_model.dart';

class RequestsStore extends GetxController {
  final Rx<RequestsModel> _requests = Rx<RequestsModel>(RequestsModel());

  void setRequests(RequestsModel del) {
    _requests(del);
  }

  Rx<RequestsModel> get requests => _requests;
}
