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
import 'package:ideas_desktop_getx/view/check-account/check-account-transactions/viewmodel/check_account_transactions_view_model.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/viewmodel/check_accounts_view_model.dart';
import 'package:ideas_desktop_getx/view/check-detail/check_detail_view_model.dart';
import 'package:ideas_desktop_getx/view/closed-check/closed-checks/viewmodel/closed_checks_view_model.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/integration_delivery_view_model.dart';
import 'package:ideas_desktop_getx/view/end-of-day/end_of_day_view_model.dart';
import 'package:ideas_desktop_getx/view/fast-sell/viewmodel/fast_sell_view_model.dart';
import 'package:ideas_desktop_getx/view/home/viewmodel/home_view_model.dart';
import 'package:ideas_desktop_getx/view/menu/condiment-groups/condiment_groups_view_model.dart';
import 'package:ideas_desktop_getx/view/menu/condiments/condiments_view_model.dart';
import 'package:ideas_desktop_getx/view/menu/menu_view_model.dart';
import 'package:ideas_desktop_getx/view/order-detail/viewmodel/order_detail_view_model.dart';
import 'package:ideas_desktop_getx/view/pos-integration/pos_integration_view_model.dart';
import 'package:ideas_desktop_getx/view/price-change/price_change_view_model.dart';
import 'package:ideas_desktop_getx/view/requests/requests_view_model.dart';
import 'package:ideas_desktop_getx/view/terminal-users/terminal_users_view_model.dart';

class ApiBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<ServerService>(() => ServerService());
    Get.lazyPut<BranchService>(() => BranchService());
    Get.lazyPut<HomeService>(() => HomeService());
    Get.lazyPut<DeliveryService>(() => DeliveryService());
    Get.lazyPut<GetirService>(() => GetirService());
    Get.lazyPut<YemeksepetiService>(() => YemeksepetiService());
    Get.lazyPut<EndOfDayService>(() => EndOfDayService());
    Get.lazyPut<StockService>(() => StockService());
    Get.lazyPut<IntegrationDeliveryController>(
        () => IntegrationDeliveryController());
    Get.lazyPut<CheckService>(() => CheckService());
    Get.lazyPut<CheckAccountService>(() => CheckAccountService());

    Get.lazyPut<EftPosService>(() => EftPosService());
    Get.lazyPut<MenuService>(() => MenuService());
    Get.lazyPut<PrinterService>(() => PrinterService());
    Get.lazyPut<TableService>(() => TableService());
    Get.lazyPut<PrinterService>(() => PrinterService());
  }
}

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class OrderDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
  }
}

class CheckAccountsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckAccountsController>(() => CheckAccountsController());
  }
}

class CheckAccountTransactionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckAccountTransactionsController>(
        () => CheckAccountTransactionsController());
  }
}

class CheckDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckDetailController>(() => CheckDetailController());
  }
}

class ClosedChecksBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosedChecksController>(() => ClosedChecksController());
  }
}

class FastSellBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FastSellController>(() => FastSellController());
  }
}

class MenuBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}

class CreateMenuItemBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMenuItemBindings>(() => CreateMenuItemBindings());
  }
}

class CondimentsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CondimentsController>(() => CondimentsController());
  }
}

class CondimentGorupsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CondimentGroupsController>(() => CondimentGroupsController());
  }
}

class PosIntegrationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosIntegrationController>(() => PosIntegrationController());
  }
}

class PriceChangeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PriceChangeController>(() => PriceChangeController());
  }
}

class RequestBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestsController>(() => RequestsController());
  }
}

class TerminalUsersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TerminalUsersController>(() => TerminalUsersController());
  }
}

class EndOfDayBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndOfDayController>(() => EndOfDayController());
  }
}

class DeliveryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntegrationDeliveryController>(
        () => IntegrationDeliveryController());
  }
}
