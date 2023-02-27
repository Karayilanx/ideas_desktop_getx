import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/model/delivery_model.dart';
import 'package:ideas_desktop_getx/service/delivery/delivery_service.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/customer-detail/model/customer_detail_page_enum.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/customer-detail/view/customer_detail_view.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/delivery-customers/delivery_customers_table.dart';

class DeliveryCustomersController extends BaseController {
  final bool showSelect = Get.arguments;
  DeliveryService deliveryService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxBool hideSearch = RxBool(true);
  RxList<DeliveryCustomerTableRowModel> customers =
      RxList<DeliveryCustomerTableRowModel>([]);
  RxList<DeliveryCustomerTableRowModel> filteredCustomers =
      RxList<DeliveryCustomerTableRowModel>([]);
  Rx<DeliveryCustomersDataSource?> deliveryCustomersDataSource =
      Rx<DeliveryCustomersDataSource?>(null);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getDeliveryCustomersForTable();
    });
  }

  Future getDeliveryCustomersForTable() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    customers(await deliveryService
        .getDeliveryCustomersForTable(authStore.user!.branchId!));
    if (customers == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else {
      filteredCustomers(customers);
      deliveryCustomersDataSource(DeliveryCustomersDataSource(
        customers: filteredCustomers,
      ));
    }
    EasyLoading.dismiss();
  }

  void filterCustomers() {
    filteredCustomers(customers
        .where((element) =>
            element.fullName!
                .toUpperCase()
                .contains(searchCtrl.text.toUpperCase()) ||
            element.phoneNumber!.contains(searchCtrl.text))
        .toList());
    deliveryCustomersDataSource(DeliveryCustomersDataSource(
      customers: filteredCustomers,
    ));
  }

  editCustomer(int deliveryCustomerId, String phoneNumber,
      int deliveryCustomerAddressId) async {
    var customer = await deliveryService.getDeliveryCustomerFromId(
        deliveryCustomerId, deliveryCustomerAddressId);
    DeliveryCustomerModel? res = await Get.dialog(CustomerDetailPage(),
        barrierDismissible: false,
        arguments: [CustomerDetailPageTypeEnum.EDIT, customer, phoneNumber]);
    if (res != null) {
      await getDeliveryCustomersForTable();
    }
  }

  addAddress(int deliveryCustomerId, String phoneNumber) async {
    var customer = await deliveryService.getDeliveryCustomerFromId(
        deliveryCustomerId, null);
    DeliveryCustomerModel? res = await Get.dialog(CustomerDetailPage(),
        barrierDismissible: false,
        arguments: [CustomerDetailPageTypeEnum.ADDRESS, customer, phoneNumber]);
    if (res != null) {
      await getDeliveryCustomersForTable();
    }
  }

  addCustomer() async {
    DeliveryCustomerModel? res = await Get.dialog(CustomerDetailPage(),
        arguments: [CustomerDetailPageTypeEnum.NEW, null, null]);
    if (res != null) {
      await getDeliveryCustomersForTable();
    }
  }

  selectCustomer(int deliveryCustomerId, String phoneNumber,
      int deliveryCustomerAddressId) async {
    var customer = await deliveryService.getDeliveryCustomerFromId(
        deliveryCustomerId, deliveryCustomerAddressId);
    Get.back(result: customer);
  }
}
