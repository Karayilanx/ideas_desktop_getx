import 'package:get/get.dart';
import 'package:ideas_desktop_getx/service/branch/branch_service.dart';
import 'package:ideas_desktop_getx/service/check/check_service.dart';
import 'package:ideas_desktop_getx/service/check_account/check_account_service.dart';
import 'package:ideas_desktop_getx/service/delivery/delivery_service.dart';
import 'package:ideas_desktop_getx/service/eft_pos/eft_pos_service.dart';
import 'package:ideas_desktop_getx/service/end_of_day/end_of_day_service.dart';
import 'package:ideas_desktop_getx/service/getir_service.dart';
import 'package:ideas_desktop_getx/service/home/home_service.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';
import 'package:ideas_desktop_getx/service/printer/printer_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';
import 'package:ideas_desktop_getx/service/stock/stock_service.dart';
import 'package:ideas_desktop_getx/service/table/table_service.dart';
import 'package:ideas_desktop_getx/service/yemeksepeti/yemeksepeti_service.dart';
import 'package:ideas_desktop_getx/view/authentication/login/service/login_service.dart';
import 'package:ideas_desktop_getx/view/authentication/login/viewmodel/login_controller.dart';
import 'package:ideas_desktop_getx/view/check-account/check-account-detail/viewmodel/check_account_detail_view_model.dart';
import 'package:ideas_desktop_getx/view/check-account/check-account-transactions/viewmodel/check_account_transactions_view_model.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/viewmodel/check_accounts_view_model.dart';
import 'package:ideas_desktop_getx/view/home/viewmodel/home_view_model.dart';
import 'package:ideas_desktop_getx/view/order-detail/viewmodel/order_detail_view_model.dart';

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
    Get.lazyPut<ServerService>(() => ServerService());
  }
}

class OrderDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
    Get.lazyPut<EftPosService>(() => EftPosService());
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<MenuService>(() => MenuService());
    Get.lazyPut<PrinterService>(() => PrinterService());
    Get.lazyPut<TableService>(() => TableService());
    Get.lazyPut<CheckAccountService>(() => CheckAccountService());
  }
}

class CheckAccountsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckAccountsController>(() => CheckAccountsController());
    Get.lazyPut<CheckService>(() => CheckService());
    Get.lazyPut<CheckAccountService>(() => CheckAccountService());
    Get.lazyPut<CheckAccountDetailController>(
        () => CheckAccountDetailController());
  }
}

class CheckAccountTransactionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckAccountTransactionsController>(
        () => CheckAccountTransactionsController());
    Get.lazyPut<PrinterService>(() => PrinterService());
    Get.lazyPut<CheckAccountService>(() => CheckAccountService());
  }
}

class CheckDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckAccountDetailController>(
        () => CheckAccountDetailController());
    Get.lazyPut<PrinterService>(() => PrinterService());
    Get.lazyPut<CheckService>(() => CheckService());
  }
}
