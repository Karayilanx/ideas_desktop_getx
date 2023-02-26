import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/bindings.dart';
import 'package:ideas_desktop_getx/theme/theme.dart';
import 'package:ideas_desktop_getx/view/authentication/auth_store.dart';
import 'package:ideas_desktop_getx/view/authentication/login/view/login_view.dart';
import 'package:ideas_desktop_getx/view/delivery/delivery_store.dart';
import 'package:ideas_desktop_getx/view/home/view/home_view.dart';
import 'package:ideas_desktop_getx/view/order-detail/view/order_detail_view.dart';
import 'package:ideas_desktop_getx/view/requests/requests_store.dart';
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
      title: 'IDEAS',
      builder: EasyLoading.init(),
      theme: ideasTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
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
          page: () => OrderDetailView(),
          binding: OrderDetailsBindings(),
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
