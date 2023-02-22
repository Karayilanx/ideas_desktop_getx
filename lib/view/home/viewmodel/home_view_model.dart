// ignore_for_file: unused_catch_clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/service/check/check_service.dart';
import 'package:ideas_desktop_getx/service/delivery/delivery_service.dart';
import 'package:ideas_desktop_getx/service/end_of_day/end_of_day_service.dart';
import 'package:ideas_desktop_getx/service/getir_service.dart';
import 'package:ideas_desktop_getx/service/home/home_service.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';
import 'package:ideas_desktop_getx/service/stock/stock_service.dart';
import 'package:ideas_desktop_getx/service/yemeksepeti/yemeksepeti_service.dart';
import 'package:ideas_desktop_getx/view/_utility/msg_dialog.dart';
import 'package:ideas_desktop_getx/view/_utility/sync_dialog/sync_dialog_view.dart';
import 'package:ideas_desktop_getx/view/delivery/delivery_store.dart';
import 'package:ideas_desktop_getx/view/home/component/new_check_dialog.dart';
import 'package:ideas_desktop_getx/view/requests/requests_store.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/delivery_model.dart';
import '../../../model/home_model.dart';

class HomeController extends BaseController {
  DeliveryStore deliveryStore = Get.find();
  RequestsStore requestsStore = Get.find();
  HomeService tableService = Get.find();
  DeliveryService deliveryService = Get.find();
  GetirService getirService = Get.find();
  YemeksepetiService yemeksepetiService = Get.find();
  EndOfDayService endOfDayService = Get.find();
  StockService stockService = Get.find();
  ServerService serverService = Get.find();
  CheckService checkService = Get.find();
  FocusNode myFocusNode = FocusNode();
  RxBool hideSearch = RxBool(true);
  TextEditingController searchCtrl = TextEditingController();
  RxList<HomeGroupWithDetails> tableGroups = RxList<HomeGroupWithDetails>([]);
  Rx<HomeGroupWithDetails?> selectedTableGroup =
      Rx<HomeGroupWithDetails?>(null);
  RxBool showBadgeGetir = RxBool(false);
  RxBool showBadgeYemeksepeti = RxBool(false);
  RxBool showBadgeRequest = RxBool(false);
  RxBool serverSignalRConnected = RxBool(true);
  RxBool tableGroupDivider = RxBool(false);
  Rx<Offset> offset = Rx<Offset>(const Offset(20, 40));
  Rx<bool?> hasFastSellCheck = Rx<bool?>(null);

  OverlayEntry? entry;

  Timer autoLockTimer = Timer(const Duration(seconds: 1), () {});

  @override
  void onInit() {
    super.onInit();
    tableGroupDivider(
        localeManager.getBoolValue(PreferencesKeys.TABLE_GROUP_DIVIDER));

    if (signalRManager.serverHubConnection.state !=
        HubConnectionState.connected) {
      serverSignalRConnected(false);
    } else {
      serverSignalRConnected(true);
    }

    signalRManager.serverHubConnection.onclose((exception) {
      serverSignalRConnected(false);
    });

    signalRManager.hubConnection.off('YeniBaglanti');
    signalRManager.hubConnection.off('Getir');
    signalRManager.hubConnection.off('Yemeksepeti');
    signalRManager.hubConnection.off('NewRequest');
    signalRManager.hubConnection.off('CallerId');
    signalRManager.serverHubConnection.off('Sync');

    signalRManager.hubConnection.on('YeniBaglanti', (asd) async {
      tableGroups(await tableService
          .getHomeGroupsWithDetails(authStore.user!.branchId!));
      if (tableGroups == null) {
        // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
      } else if (tableGroups.isNotEmpty) {
        if (selectedTableGroup.value != null) {
          selectedTableGroup(tableGroups
              .where((element) =>
                  element.tableGroupId ==
                  selectedTableGroup.value!.tableGroupId)
              .first);
        } else {
          selectedTableGroup(tableGroups[0]);
        }
        hasFastSellCheck(tableGroups[0].hasFastSellCheck == true);
      }
    });

    signalRManager.hubConnection.on('Getir', (msg) async {
      if (msg!.first == 'Yeni Sipariş') {
        await checkGetir();
      } else if (msg.first == 'Temiz') {
        clearGetirBadge();
      }
    });

    signalRManager.hubConnection.on('Yemeksepeti', (msg) async {
      if (msg!.first == 'Yeni Sipariş') {
        await checkYemeksepeti();
      } else if (msg.first == 'Temiz') {
        clearYemeksepetiBadge();
      }
    });
    signalRManager.hubConnection.on('NewRequest', (asd) async {
      await getRequests();
    });
    signalRManager.hubConnection.on('CallerId', (asd) async {
      if (asd != null) {
        DeliveryCustomerModel customer = DeliveryCustomerModel.fromJson(asd[0]);
        if (entry != null) {
          entry!.remove();
          entry = null;
        }
        showOverlay(customer);
      }
    });
    signalRManager.serverHubConnection.on('Sync', (arguments) async {
      var res =
          await serverService.checkServerChanges(authStore.user!.branchId!);
      if (res != null && res.message != null) {
        await Get.dialog(
          MsgDialog(msg: res.message!),
          barrierDismissible: res.message!.msgTypeId != 2,
        );
      }
      if (res != null && res.changeCount! > 0) {
        Get.dialog(
          SyncDialog(),
          barrierDismissible: false,
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await doStartupOperations();
      await checkServer();
      await getTableGroups();
      await refreshGetir();
      await refreshYemeksepeti();
      await checkYemeksepeti();
      await checkGetir();
      await getRequests();
      createAutoLockTimer();
    });
  }

  Future getRestaurantList() async {
    await yemeksepetiService.getRestaurantList(authStore.user!.branchId!);
  }

  cancelAutoLockTimer() {
    autoLockTimer.cancel();
    authStore.setAutoLockTimerStarted(false);
  }

  createAutoLockTimer() {
    if (localeManager.getBoolValue(PreferencesKeys.AUTO_LOCK_2) &&
        !authStore.autoLockTimerStarted.value) {
      authStore.setAutoLockTimerStarted(true);
      autoLockTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          // Update user about remaining time
          if (timer.tick == 120) {
            timer.cancel();
            authStore.setAutoLockTimerStarted(false);
            lockScreen();
          }
        },
      );
    }
  }

  Future doStartupOperations() async {
    if (authStore.serverChecked.value == false) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await serverService.doStartupOperations(authStore.user!.branchId!);
      EasyLoading.dismiss();
    }
  }

  Future checkServer() async {
    if (authStore.serverChecked.value == false) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );

      await getRestaurantList();

      var res =
          await serverService.checkServerChanges(authStore.user!.branchId!);
      EasyLoading.dismiss();
      authStore.setServerChecked(true);
      if (res != null && res.message != null) {
        await Get.dialog(
          MsgDialog(msg: res.message!),
          barrierDismissible: res.message!.msgTypeId != 2,
        );
      }
      if (res != null && res.changeCount! > 0) {
        Get.dialog(
          SyncDialog(),
          barrierDismissible: false,
        );
      } else if (res != null && res.unsendEndOfDaysCount! > 0) {
        await sendEndOfDaysToServer();
      }
    }
  }

  Future sendEndOfDaysToServer() async {
    var res = await openYesNoDialog(
        'Sunucuya atılmayan gün sonlarını şimdi aktarmak ister misiniz?');

    if (res == true) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var result = await endOfDayService
          .sendEndOfDaysToServer(authStore.user!.branchId!);
      EasyLoading.dismiss();

      if (result != null) {
        if (result.value! > 0) {
          showSnackbarError(
              '${result.value} adet gün sonu, sunucuya başarıyla aktarıldı.');
        } else {
          showSnackbarError('Sunucuya aktarılmamış bir gün sonu bulunamadı.');
        }

        await calculateStocks();
      }
    }
  }

  Future calculateStocks() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );

    var ends = await endOfDayService
        .getNotCalculatedEndOfDays(authStore.user!.branchId!);

    if (ends != null) {
      for (var i = 0; i < ends.length; i++) {
        var end = ends[i];
        var res = await stockService.calculateEndOfDayStocks(
            end.endOfDayId!, end.branchId!);
        if (res == null || res.value! < 0) {
          showSnackbarError('Stok hesaplanırken hata oluştu!');
          break;
        }
      }
    }
  }

  Future getRequests() async {
    var res = await checkService.getRequests(authStore.user!.branchId!);
    if (res != null) {
      requestsStore.setRequests(res);
      if (res.cancelRequests!.isNotEmpty || res.qrRequests!.isNotEmpty) {
        showBadgeRequest(true);
      } else {
        showBadgeRequest(false);
      }
    }
  }

  Future<void> checkGetir() async {
    try {
      var res = await deliveryService
          .getTodaysDeliveryOrders(authStore.user!.branchId!);
      if (res != null) {
        deliveryStore.setDeliveries(res);
        List<DeliveryListItem> newGetirDeliveries = res
            .where((order) =>
                order.deliveryStatusTypeId ==
                    DeliveryStatusTypeEnum.NewOrder.index &&
                order.getirId != null &&
                order.getirId != '')
            .toList();
        if (newGetirDeliveries.isNotEmpty) {
          showBadgeGetir(true);
        } else {
          showBadgeGetir(false);
        }
      }
    } on Exception catch (e) {
      //
    }
  }

  clearGetirBadge() {
    showBadgeGetir(false);
  }

  clearYemeksepetiBadge() {
    showBadgeYemeksepeti(false);
  }

  Future<void> checkYemeksepeti() async {
    try {
      var res = await deliveryService
          .getTodaysDeliveryOrders(authStore.user!.branchId!);
      if (res != null) {
        deliveryStore.setDeliveries(res);
        List<DeliveryListItem> newGetirDeliveries = res
            .where((order) =>
                order.deliveryStatusTypeId ==
                    DeliveryStatusTypeEnum.NewOrder.index &&
                order.yemeksepetiId != null &&
                order.yemeksepetiId != '')
            .toList();
        if (newGetirDeliveries.isNotEmpty) {
          showBadgeYemeksepeti(true);
        } else {
          showBadgeYemeksepeti(false);
        }
      }
    } on Exception catch (e) {
      //
    }
  }

  Future refreshYemeksepeti() async {
    await yemeksepetiService.refreshYemeksepeti(authStore.user!.branchId!);
  }

  Future refreshGetir() async {
    await getirService.refreshGetir(authStore.user!.branchId!);
  }

  Future getTableGroups() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    tableGroups(
        await tableService.getHomeGroupsWithDetails(authStore.user!.branchId!));

    EasyLoading.dismiss();

    if (tableGroups == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else if (tableGroups.isNotEmpty) {
      tableGroups(tableGroups
          .where(
              (element) => element.tables!.isNotEmpty || element.name == "Tümü")
          .toList());
      if (selectedTableGroup.value != null) {
        selectedTableGroup(tableGroups
            .where((element) =>
                element.tableGroupId == selectedTableGroup.value!.tableGroupId)
            .first);
      } else {
        selectedTableGroup(tableGroups[0]);
      }
      hasFastSellCheck(tableGroups[0].hasFastSellCheck == true);
    }
  }

  void changeTableGroup(HomeGroupWithDetails? group) {
    selectedTableGroup(group);
  }

  void navigateToTableDetail(int? tableId, int? checkId) {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //         path: NavigationConstants.TABLE_DETAIL_VIEW,
    //         data: TableDetailArguments(
    //           tableId: tableId,
    //           type: tableId != null && tableId > 0
    //               ? OrderDetailPageType.TABLE
    //               : OrderDetailPageType.ALIAS,
    //           checkId: checkId,
    //           isIntegration: false,
    //         ))
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToDeliveryOrder() {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(path: NavigationConstants.DELIVERY_ORDERS_VIEW)
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToCheckAccounts() {
    if (authStore.user!.canSendCheckToCheckAccount!) {
      cancelAutoLockTimer();
      // navigation
      //     .navigateToPage(
      //         path: NavigationConstants.CHECK_ACCOUNTS,
      //         data: CheckAccountsArguments(
      //           checkId: null,
      //           type: CheckAccountsPageType.CheckAccount,
      //           transferAll: null,
      //           menuItems: null,
      //         ))
      //     .then((value) => createAutoLockTimer());
    } else {
      showSnackbarError(
          '${authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
    }
  }

  void navigateToClosedChecks() {
    if (authStore.user!.canRestoreCheck!) {
      cancelAutoLockTimer();
      // navigation
      //     .navigateToPage(
      //       path: NavigationConstants.CLOSED_CHECKS,
      //     )
      //     .then((value) => createAutoLockTimer());
    } else {
      showSnackbarError(
          '${authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
    }
  }

  void navigateToEndOfDay() {
    if (authStore.user!.canEndDay!) {
      cancelAutoLockTimer();
      // navigation
      //     .navigateToPage(
      //       path: NavigationConstants.END_OF_DAY_VIEW,
      //     )
      //     .then((value) => createAutoLockTimer());
    } else {
      showSnackbarError(
          '${authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
    }
  }

  void navigateToRequests() {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.REQUESTS_VIEW,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToMenuPage() {
    if (!authStore.user!.isAdmin!) {
      showSnackbarError(
          'Kullanıcının admin yetkisi olmadığından ötürü sayfa açılamıyor!');
      return;
    }

    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.MENU_VIEW,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToCondimentsPage() {
    if (!authStore.user!.isAdmin!) {
      showSnackbarError(
          'Kullanıcının admin yetkisi olmadığından ötürü sayfa açılamıyor!');
      return;
    }

    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.CONDIMENTS,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToCondimentGroupsPage() {
    if (!authStore.user!.isAdmin!) {
      showSnackbarError(
          'Kullanıcının admin yetkisi olmadığından ötürü sayfa açılamıyor!');
      return;
    }

    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.CONDIMENT_GROUPS,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToPosIntegrationPage() {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.POS_INTEGRATION,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToPriceChangePage() {
    if (!authStore.user!.isAdmin!) {
      showSnackbarError(
          'Kullanıcının admin yetkisi olmadığından ötürü sayfa açılamıyor!');
      return;
    }

    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.PRICE_CHANGE,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToTerminalUsersPage() {
    if (!authStore.user!.isAdmin!) {
      showSnackbarError(
          'Kullanıcının admin yetkisi olmadığından ötürü sayfa açılamıyor!');
      return;
    }

    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.TERMINAL_USERS,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToNetworkInfoPage() {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(
    //       path: NavigationConstants.NETWORK_INFO_VIEW,
    //     )
    //     .then((value) => createAutoLockTimer());
  }

  void navigateToFastSell() {
    cancelAutoLockTimer();
    // navigation
    //     .navigateToPage(path: NavigationConstants.FAST_SELL_VIEW)
    //     .then((value) => createAutoLockTimer());
  }

  void lockScreen() {
    Get.offAllNamed('/');
  }

  Future openNewCheckDialog() async {
    cancelAutoLockTimer();
    String? res = await Get.dialog(InputDialog(
      hintText: 'Hesap adı giriniz.',
      titleText: 'Yeni Hesap Adı',
      inputType: TextInputType.text,
    ));
    if (res != null && res.toString().trim().isNotEmpty) {
      cancelAutoLockTimer();
      // navigation
      //     .navigateToPage(
      //         path: NavigationConstants.TABLE_DETAIL_VIEW,
      //         data: TableDetailArguments(
      //           alias: res,
      //           type: OrderDetailPageType.ALIAS,
      //           checkId: -1,
      //           tableId: -1,
      //           isIntegration: false,
      //         ))
      //     .then((value) => createAutoLockTimer());
    } else {
      createAutoLockTimer();
    }
  }

  void changeShowSearch() {
    hideSearch(!hideSearch.value);
    if (!hideSearch.value) {
      myFocusNode.requestFocus();
    }
    searchCtrl.text = '';
  }

  //   void filterTables() {
  //   tableGroups = tableGroups;
  // }

  reconnectServer() async {
    if (signalRManager.serverHubConnection.state ==
        HubConnectionState.disconnected) {
      showSpinner('Tekrar Deneniyor');
      try {
        await signalRManager.serverHubConnection.start();
        Get.back();
      } on Exception {
        Get.back();
      }
    }

    if (signalRManager.serverHubConnection.state ==
        HubConnectionState.connected) serverSignalRConnected(true);
  }

  updateOffset(Offset d) {
    offset(offset.value - d);
    entry!.markNeedsBuild();
  }

  void showOverlay(DeliveryCustomerModel? customer) {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: offset.value.dy,
        right: offset.value.dx,
        child: GestureDetector(
          onPanUpdate: (details) {
            updateOffset(details.delta);
          },
          onTap: () {
            if (authStore.user != null) {
              entry!.remove();
              entry = null;
              // navigation.navigateToPage(
              //     path: NavigationConstants.RESTAURANT_DELIVERY_ORDER,
              //     data: RestaurantDeliveryArguments(
              //         customerId: customer!.deliveryCustomerId,
              //         phoneNumber: customer.phoneNumber));
            } else {
              showSnackbarError("Lütfen giriş yapınız!");
            }
          },
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: const Color(0xFF223540),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.phone, color: Colors.red, size: 30),
                      SizedBox(width: 8),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        child: Text(
                          'Paket Servis',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            const DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              child: Text(
                                "Gelen Arama",
                              ),
                            ),
                            customer != null
                                ? Column(
                                    children: [
                                      DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          "${customer.name!} ${customer.lastName!}",
                                        ),
                                      ),
                                      DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          customer.phoneNumber!,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "Yeni Müşteri",
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (authStore.user != null) {
                                    entry!.remove();
                                    entry = null;
                                    // navigation.navigateToPage(
                                    //     path: NavigationConstants
                                    //         .RESTAURANT_DELIVERY_ORDER,
                                    //     data: RestaurantDeliveryArguments(
                                    //         customerId:
                                    //             customer!.deliveryCustomerId,
                                    //         phoneNumber: customer.phoneNumber));
                                  } else {
                                    showSnackbarError("Lütfen giriş yapınız!");
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFDE9452)),
                                ),
                                child: const Text(
                                  "Sipariş Al",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  entry!.remove();
                                  entry = null;
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                ),
                                child: const Text(
                                  "Kapat",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final overlay = Overlay.of(Get.context!);
    overlay.insert(entry!);
  }

  hideOverlay() {
    if (entry != null) {
      entry!.remove();
      entry = null;
    }
  }
}
