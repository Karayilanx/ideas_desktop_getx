import 'package:get/get.dart';
import 'package:ideas_desktop_getx/service/branch/branch_service.dart';
import 'package:ideas_desktop_getx/service/check/check_service.dart';
import 'package:ideas_desktop_getx/service/delivery/delivery_service.dart';
import 'package:ideas_desktop_getx/service/end_of_day/end_of_day_service.dart';
import 'package:ideas_desktop_getx/service/getir_service.dart';
import 'package:ideas_desktop_getx/service/home/home_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';
import 'package:ideas_desktop_getx/service/stock/stock_service.dart';
import 'package:ideas_desktop_getx/service/yemeksepeti/yemeksepeti_service.dart';
import 'package:ideas_desktop_getx/view/authentication/login/service/login_service.dart';
import 'package:ideas_desktop_getx/view/authentication/login/viewmodel/login_controller.dart';
import 'package:ideas_desktop_getx/view/home/viewmodel/home_view_model.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<ServerService>(() => ServerService());
    Get.lazyPut<BranchService>(() => BranchService());
  }
}

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeService>(() => HomeService());
    Get.lazyPut<DeliveryService>(() => DeliveryService());
    Get.lazyPut<GetirService>(() => GetirService());
    Get.lazyPut<YemeksepetiService>(() => YemeksepetiService());
    Get.lazyPut<EndOfDayService>(() => EndOfDayService());
    Get.lazyPut<StockService>(() => StockService());
    Get.lazyPut<CheckService>(() => CheckService());
  }
}
