import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/service/getir_service.dart';
import 'package:ideas_desktop/view/delivery/table/integration_delivery_order_table.dart';
import 'package:ideas_desktop/view/getir/getir-cancel/getir_cancel_view.dart';
import 'package:ideas_desktop/view/getir/getir-order-detail/view/getir_order_view.dart';
import 'package:ideas_desktop/view/order-detail/navigation/table_detail_navigation_args.dart';
import 'package:ideas_desktop/view/yemeksepeti/yemeksepeti-cancel/yemeksepeti_cancel_view.dart';
import 'package:ideas_desktop/view/yemeksepeti/yemeksepeti-order-detail/view/yemeksepeti_order_view.dart';

import '../../../locale_keys_enum.dart';
import '../../../model/delivery_model.dart';
import '../../../model/yemeksepeti_model.dart';
import '../../../service/delivery/delivery_service.dart';
import '../../../service/yemeksepeti/yemeksepeti_service.dart';
import '../../order-detail/model/order_detail_model.dart';
import '../delivery_store.dart';
import 'component/update-status-dialog/update_status_dialog_view.dart';

class IntegrationDeliveryController extends BaseController {
  DeliveryService deliveryService = Get.find();
  GetirService getirService = Get.find();
  YemeksepetiService yemeksepetiService = Get.find();
  DeliveryStore deliveryStore = Get.find();
  YemeksepetiRestaurantModel? restaurantModel;

  RxInt selectedDeliveryStatusType = RxInt(0);
  RxInt selectedIntegration = RxInt(0);
  RxBool getirRestaurantStatus = RxBool(true);
  RxBool getirCourierStatus = RxBool(true);
  RxBool yemeksepetiRestaurantStatus = RxBool(true);
  RxBool isLoading = RxBool(true);
  Rx<IntegrationDeliveryOrderDataSource?> source =
      Rx<IntegrationDeliveryOrderDataSource?>(null);

  @override
  void onInit() {
    super.onInit();

    ever(deliveryStore.deliveries, (_) {
      filterOrders();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      changeLoading(true);
      await getTodaysDeliverys();
      await changeSelectedIntegration(2);
      if (localeManager.getBoolValue(PreferencesKeys.USE_YEMEKSEPETI)) {
        await isRestaurantOpen();
        // await getRestaurantYemeksepeti();
        await changeSelectedIntegration(0);
      } else if (localeManager.getBoolValue(PreferencesKeys.USE_GETIR)) {
        // await getGetirRestaurantStatus();
        await changeSelectedIntegration(1);
      } else if (localeManager.getBoolValue(PreferencesKeys.USE_FUUDY)) {
        // await getGetirRestaurantStatus();
        await changeSelectedIntegration(3);
      }

      changeLoading(false);
    });
  }

  changeLoading(bool value) {
    isLoading(value);
  }

  Future getGetirRestaurantStatus() async {
    var res = await getirService.getRestaurantStatus(authStore.user!.branchId!);
    if (res != null) {
      getirCourierStatus(res.isCourierAvailable!);
      getirRestaurantStatus(res.restaurantStatus! == 100);
    }
  }

  Future isRestaurantOpen() async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res =
        await yemeksepetiService.isRestaurantOpen(authStore.user!.branchId!);
    if (res != null) {
      yemeksepetiRestaurantStatus(res.result!);
    }

    EasyLoading.dismiss();
  }

  Future getTodaysDeliverys() async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await deliveryService
        .getTodaysDeliveryOrders(authStore.user!.branchId!);
    EasyLoading.dismiss();
    if (res == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else {
      deliveryStore.setDeliveries(res);
      filterOrders();
    }
  }

  void filterOrders() {
    if (selectedDeliveryStatusType.value == 0) {
      if (selectedIntegration.value == 0) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.yemeksepetiId != null &&
                  order.yemeksepetiId != '' &&
                  (order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Completed.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.WaitingForSchedule.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 1) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.getirId != null &&
                  order.getirId != '' &&
                  (order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Completed.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.WaitingForSchedule.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 2) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.deliverySourceTypeId == 0 &&
                  (order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Completed.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.WaitingForSchedule.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 3) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.fuudyId != null &&
                  (order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Completed.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.WaitingForSchedule.index &&
                      order.deliveryStatusTypeId !=
                          DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      }
    } else if (selectedDeliveryStatusType.value == 1) {
      if (selectedIntegration.value == 0) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.yemeksepetiId != null &&
                  order.yemeksepetiId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Completed.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 1) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.getirId != null &&
                  order.getirId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Completed.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 2) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.deliverySourceTypeId == 0 &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Completed.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 3) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.fuudyId != null &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Completed.index)))
              .toList(),
        ));
      }
    } else if (selectedDeliveryStatusType.value == 2) {
      if (selectedIntegration.value == 0) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.yemeksepetiId != null &&
                  order.yemeksepetiId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 1) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.getirId != null &&
                  order.getirId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 2) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.deliverySourceTypeId == 0 &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 3) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.fuudyId != null &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.Cancelled.index)))
              .toList(),
        ));
      }
    } else if (selectedDeliveryStatusType.value == 3) {
      if (selectedIntegration.value == 0) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.yemeksepetiId != null &&
                  order.yemeksepetiId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.WaitingForSchedule.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 1) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.getirId != null &&
                  order.getirId != '' &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.WaitingForSchedule.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 2) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.deliverySourceTypeId == 0 &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.WaitingForSchedule.index)))
              .toList(),
        ));
      } else if (selectedIntegration.value == 3) {
        source(IntegrationDeliveryOrderDataSource(
          deliveries: deliveryStore.deliveries
              .where((order) => (order.fuudyId != null &&
                  (order.deliveryStatusTypeId ==
                      DeliveryStatusTypeEnum.WaitingForSchedule.index)))
              .toList(),
        ));
      }
    }
  }

  Future changeRestaurantStatus(bool value) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await getGetirRestaurantStatus();
    EasyLoading.dismiss();
    if (getirRestaurantStatus.value != value) {
      if (!value) {
        var res =
            await openYesNoDialog('Restoran kapatılcak. Onaylıyor musunuz?');
        if (res) {
          EasyLoading.show(
            status: 'Lütfen bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await getirService.closeRestaurant(authStore.user!.branchId!);
          await getGetirRestaurantStatus();
          EasyLoading.dismiss();
        }
      }
      if (value) {
        var res =
            await openYesNoDialog('Restoran açılıcak. Onaylıyor musunuz?');
        if (res) {
          EasyLoading.show(
            status: 'Restoran açılıyor...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await getirService.openRestaurant(authStore.user!.branchId!);
          await getGetirRestaurantStatus();
          EasyLoading.dismiss();
        }
      }
    }
  }

  void changeDeliveryStatus(int index) {
    selectedDeliveryStatusType(index);
    getTodaysDeliverys();
  }

  Future changeCourierStatus(bool value) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );

    await getGetirRestaurantStatus();
    EasyLoading.dismiss();
    if (getirCourierStatus.value != value) {
      if (!value) {
        var res = await openYesNoDialog(
            'Kurye durumu kapatılcak. Onaylıyor musunuz?');
        if (res) {
          EasyLoading.show(
            status: 'Lütfen bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await getirService.disableCourier(authStore.user!.branchId!);
          await getGetirRestaurantStatus();
          EasyLoading.dismiss();
        }
      }
      if (value) {
        var res =
            await openYesNoDialog('Kurye durumu açılıcak. Onaylıyor musunuz?');
        if (res) {
          EasyLoading.show(
            status: 'Lütfen bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await getirService.enableCourier(authStore.user!.branchId!);
          await getGetirRestaurantStatus();
          EasyLoading.dismiss();
        }
      }
    }
  }

  Future changeSelectedIntegration(int index) async {
    selectedIntegration(index);
    await getTodaysDeliverys();
  }

  Future openGetirCancelDialog(String id) async {
    var res = await Get.dialog(const GetirCancelPage(), arguments: id);
    if (res != null) {
      await cancelGetiriOrder(id, res[0], res[1]);
    }
  }

  Future cancelGetiriOrder(
      String getirId, String? reason, String rejectReasonId) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await getirService.cancelGetirOrder(
        authStore.user!.branchId!, getirId, rejectReasonId, reason!);
    EasyLoading.dismiss();
    await getTodaysDeliverys();
  }

  Future openYemeksepetiCancelDialog(String id) async {
    var res = await Get.dialog(const YemeksepetiCancelPage(), arguments: id);
    if (res != null) {
      if (restaurantModel != null) {
        if (restaurantModel!.isVale!) {
          await cancelYemeksepetiOrder(id, res[0], res[1]);
        } else {
          await cancelYemeksepetiValeOrder(id, res[0], res[1]);
        }
      }
    }
  }

  Future cancelYemeksepetiOrder(
      String yemeksepetiId, String? reason, String rejectReasonId) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await yemeksepetiService.rejectYemeksepetiOrder(
        authStore.user!.branchId!, yemeksepetiId, reason!, rejectReasonId);
    EasyLoading.dismiss();
    await getTodaysDeliverys();
  }

  Future cancelYemeksepetiValeOrder(
      String yemeksepetiId, String? reason, String rejectReasonId) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await yemeksepetiService.rejectYemeksepetiValeOrder(
        authStore.user!.branchId!, yemeksepetiId, reason!, rejectReasonId);
    EasyLoading.dismiss();
    await getTodaysDeliverys();
  }

  void navigateToDeliveryOrder(int? checkId, bool isIntegration) async {
    if (isIntegration) {
      await Get.toNamed('/order-detail',
          arguments: TableDetailArguments(
              tableId: -1,
              checkId: checkId,
              type: OrderDetailPageType.DELIVERY,
              isIntegration: true,
              alias: null));
    } else {
      await Get.toNamed('/order-detail',
          arguments: TableDetailArguments(
              tableId: -1,
              checkId: checkId,
              type: OrderDetailPageType.DELIVERY,
              isIntegration: false,
              alias: null));
    }
    getTodaysDeliverys();
  }

  Future openGetirDialog(String getirId) async {
    await Get.dialog(const GetirOrderPage(), arguments: getirId);
    await getTodaysDeliverys();
  }

  Future openYemeksepetiDialog(String yemeksepetiId) async {
    await Get.dialog(
      const YemeksepetiOrderPage(),
      arguments: yemeksepetiId,
    );
    await getTodaysDeliverys();
  }

  Future openUpdateStatusDialog(
      String? getirId, String? yemeksepetiId, int? fuudyId) async {
    await Get.dialog(UpdateStatusDialog(), arguments: [
      getirId,
      yemeksepetiId,
      fuudyId,
      restaurantModel != null ? restaurantModel!.isVale! : false,
    ]);
    await getTodaysDeliverys();
  }

  Future navigateToRestaurantDeliveryOrder() async {
    // await navigation.navigateToPage(
    //     path: NavigationConstants.RESTAURANT_DELIVERY_ORDER,
    //     data: RestaurantDeliveryArguments(customerId: null, phoneNumber: null));
    await getTodaysDeliverys();
  }

  Future navigateToDeliveryOrderDetail(int checkId) async {
    // await navigation.navigateToPage(
    //     path: NavigationConstants.DELIVERY_ORDER__DETAIL_VIEW,
    //     data: DeliveryOrderDetailArguments(checkId: checkId));
    await getTodaysDeliverys();
  }

  Future updateRestaurantState(bool val) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await yemeksepetiService.updateRestaurantState(
        authStore.user!.branchId!, val ? 0 : 1);
    EasyLoading.dismiss();
    await isRestaurantOpen();
  }

  setCourier(int checkId, int courierId) async {
    EasyLoading.show(
      status: 'Lütfen bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await deliveryService.setCourier(checkId, courierId);
    await getTodaysDeliverys();
    EasyLoading.dismiss();
  }

  //   Future openFuudyDialog(int fuudyId) async {
  //   await showDialog(
  //     context: buildContext!,
  //     builder: (context) {
  //       return FuudyOrderPage(fuudyId: fuudyId);
  //     },
  //   );
  //   await getTodaysDeliverys();
  // }
}
