import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/bindings.dart';
import 'package:ideas_desktop_getx/theme/theme.dart';
import 'package:ideas_desktop_getx/view/authentication/auth_store.dart';
import 'package:ideas_desktop_getx/view/authentication/login/view/login_view.dart';
import 'package:ideas_desktop_getx/view/check-account/check-account-transactions/view/check_account_transactions_view.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/view/check_accounts_view.dart';
import 'package:ideas_desktop_getx/view/closed-check/closed-checks/view/closed_checks_view.dart';
import 'package:ideas_desktop_getx/view/delivery/delivery_store.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/integration_delivery_view.dart';
import 'package:ideas_desktop_getx/view/end-of-day/end_of_day_view.dart';
import 'package:ideas_desktop_getx/view/fast-sell/view/fast_sell_view.dart';
import 'package:ideas_desktop_getx/view/home/view/home_view.dart';
import 'package:ideas_desktop_getx/view/menu/condiment-groups/condiment_groups_view.dart';
import 'package:ideas_desktop_getx/view/menu/condiments/condiments_view.dart';
import 'package:ideas_desktop_getx/view/menu/create-menu-item/create_menu_item_view.dart';
import 'package:ideas_desktop_getx/view/menu/menu_view.dart';
import 'package:ideas_desktop_getx/view/order-detail/view/order_detail_view.dart';
import 'package:ideas_desktop_getx/view/pos-integration/pos_integration_view.dart';
import 'package:ideas_desktop_getx/view/price-change/price_change_view.dart';
import 'package:ideas_desktop_getx/view/requests/requests_store.dart';
import 'package:ideas_desktop_getx/view/requests/requests_view.dart';
import 'package:ideas_desktop_getx/view/terminal-users/terminal_users_view.dart';
import 'package:window_manager/window_manager.dart';

import 'locale_manager.dart';
import 'signalr/signalr_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    if (!Platform.isLinux) {
      // await windowManager.setTitleBarStyle('hidden');
      // await windowManager.setFullScreen(true);
      await windowManager.setTitle("IDEAS");
      // await windowManager.maximize();
    }
  });
  await SignalRManager.hubConnectionStart().catchError((_) => {});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<AuthStore>(AuthStore(), permanent: true);
    Get.put<DeliveryStore>(DeliveryStore(), permanent: true);
    Get.put<RequestsStore>(RequestsStore(), permanent: true);
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      initialBinding: ApiBindings(),
      title: 'IDEAS',
      builder: EasyLoading.init(),
      theme: ideasTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginPage(),
          binding: LoginBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/order-detail',
          page: () => const OrderDetailView(),
          binding: OrderDetailsBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/check-accounts',
          page: () => const CheckAccountsPage(),
          binding: CheckAccountsBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/check-acoount-transactions',
          page: () => const CheckAccountTransactionsPage(),
          binding: CheckAccountTransactionBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/closed-checks',
          page: () => const ClosedChecksPage(),
          binding: ClosedChecksBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/fast-sell',
          page: () => const FastSellPage(),
          binding: FastSellBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/menu',
          page: () => const MenuPage(),
          binding: MenuBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/create-menu-item',
          page: () => const CreateMenuItemPage(),
          binding: CreateMenuItemBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/condiments',
          page: () => const CondimentsPage(),
          binding: CondimentsBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/condiment-groups',
          page: () => const CondimentGroupsPage(),
          binding: CondimentGorupsBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/pos-integration',
          page: () => const PosIntegrationView(),
          binding: PosIntegrationBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/price-change',
          page: () => const PriceChangePage(),
          binding: PriceChangeBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/requests',
          page: () => const RequestsPage(),
          binding: RequestBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/terminal-users',
          page: () => const TerminalUsersPage(),
          binding: TerminalUsersBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/end-of-day',
          page: () => EndOfDayPage(),
          binding: EndOfDayBindings(),
          transitionDuration: Duration.zero,
        ),
        GetPage(
          name: '/delivery',
          page: () => const IntegrationDeliveryPage(),
          binding: DeliveryBindings(),
          transitionDuration: Duration.zero,
        ),
      ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  // ignore: override_on_non_overriding_member
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
