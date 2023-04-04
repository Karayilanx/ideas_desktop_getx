import 'package:get/get.dart';
import 'service/branch/branch_service.dart';
import 'service/check/check_service.dart';
import 'service/check_account/check_account_service.dart';
import 'service/delivery/delivery_service.dart';
import 'service/eft_pos/eft_pos_service.dart';
import 'service/end_of_day/end_of_day_service.dart';
import 'service/getir_service.dart';
import 'service/home/home_service.dart';
import 'service/menu/menu_service.dart';
import 'service/printer/printer_service.dart';
import 'service/stock/stock_service.dart';
import 'service/table/table_service.dart';
import 'service/yemeksepeti/yemeksepeti_service.dart';
import 'view/authentication/login/viewmodel/login_controller.dart';
import 'view/check-account/check-account-transactions/viewmodel/check_account_transactions_view_model.dart';
import 'view/check-account/check-accounts/viewmodel/check_accounts_view_model.dart';
import 'view/check-detail/check_detail_view_model.dart';
import 'view/closed-check/closed-checks/viewmodel/closed_checks_view_model.dart';
import 'view/delivery/integration-delivery/integration_delivery_view_model.dart';
import 'view/end-of-day/end_of_day_view_model.dart';
import 'view/fast-sell/viewmodel/fast_sell_view_model.dart';
import 'view/home/viewmodel/home_view_model.dart';
import 'view/menu/condiment-groups/condiment_groups_view_model.dart';
import 'view/menu/condiments/condiments_view_model.dart';
import 'view/menu/menu_view_model.dart';
import 'view/order-detail/viewmodel/order_detail_view_model.dart';
import 'view/pos-integration/pos_integration_view_model.dart';
import 'view/price-change/price_change_view_model.dart';
import 'view/requests/requests_view_model.dart';
import 'view/terminal-users/terminal_users_view_model.dart';

import 'service/server/server_service.dart';
import 'view/authentication/login/service/login_service.dart';

class ApiBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginService>(() => LoginService(), fenix: true);
    Get.lazyPut<ServerService>(() => ServerService(), fenix: true);
    Get.lazyPut<BranchService>(() => BranchService(), fenix: true);
    Get.lazyPut<HomeService>(() => HomeService(), fenix: true);
    Get.lazyPut<DeliveryService>(() => DeliveryService(), fenix: true);
    Get.lazyPut<GetirService>(() => GetirService(), fenix: true);
    Get.lazyPut<YemeksepetiService>(() => YemeksepetiService(), fenix: true);
    Get.lazyPut<EndOfDayService>(() => EndOfDayService(), fenix: true);
    Get.lazyPut<StockService>(() => StockService(), fenix: true);

    Get.lazyPut<CheckService>(() => CheckService(), fenix: true);
    Get.lazyPut<CheckAccountService>(() => CheckAccountService(), fenix: true);

    Get.lazyPut<EftPosService>(() => EftPosService(), fenix: true);
    Get.lazyPut<MenuService>(() => MenuService(), fenix: true);
    Get.lazyPut<PrinterService>(() => PrinterService(), fenix: true);
    Get.lazyPut<TableService>(() => TableService(), fenix: true);
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
    Get.lazyPut<RequestsController>(() => RequestsController(), fenix: true);
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
        () => IntegrationDeliveryController(),
        fenix: true);
  }
}
