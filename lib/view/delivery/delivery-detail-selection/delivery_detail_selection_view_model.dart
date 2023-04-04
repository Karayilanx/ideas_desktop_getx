import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/model/delivery_model.dart';
import 'package:ideas_desktop/service/delivery/delivery_service.dart';
import 'package:ideas_desktop/view/delivery/customer/customer-detail/model/customer_detail_page_enum.dart';
import 'package:ideas_desktop/view/delivery/customer/customer-detail/view/customer_detail_view.dart';

class DeliveryDetailSelectionController extends BaseController {
  Rx<DeliveryModel?> delivery = Rx<DeliveryModel?>(Get.arguments[0]);
  Rx<DeliveryCustomerModel?> selectedCustomer =
      Rx<DeliveryCustomerModel?>(Get.arguments[1]);
  Rx<DeliveryCustomerAddressModel?> selectedAddress =
      Rx<DeliveryCustomerAddressModel?>(null);
  Rx<int?> selectedAddressIdForDropdown = Rx<int?>(null);
  RxInt selectedDeliveryTimeType = RxInt(0);
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  Rx<TimeOfDay> selectedDeliveryTime = Rx<TimeOfDay>(TimeOfDay.now());

  DeliveryService deliveryService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxBool hideSearch = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (selectedCustomer.value != null) {
        await getDeliveryCustomersAddresses(
            selectedCustomer.value!.deliveryCustomerId!);

        if (delivery.value!.deliveryDate != null) {
          selectedDeliveryTimeType(1);
          selectedDate(delivery.value!.deliveryDate!);
          selectedDeliveryTime(TimeOfDay(
            hour: delivery.value!.deliveryDate!.hour,
            minute: delivery.value!.deliveryDate!.minute,
          ));
        }
      }
    });
  }

  Future getDeliveryCustomersAddresses(int deliveryCustomerId) async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    selectedCustomer(await deliveryService.getDeliveryCustomerFromId(
        deliveryCustomerId, null));

    selectedAddress(selectedCustomer.value != null
        ? selectedCustomer.value!.deliveryCustomerAddresses![0]
        : null);

    if (selectedAddress.value != null) {
      selectedAddressIdForDropdown(
          selectedAddress.value!.deliveryCustomerAddressId);
    }
    selectedCustomer.update((val) {
      val!.deliveryCustomerAddresses!.add(DeliveryCustomerAddressModel(
        address: "GEL AL",
        addressDefinition: "",
        addressTitle: "GEL AL",
        deliveryCustomerAddressId: -1,
        deliveryCustomerId: selectedCustomer.value!.deliveryCustomerId,
      ));
    });
    EasyLoading.dismiss();
  }

  selectCustomer(DeliveryCustomerModel customer) async {
    selectedCustomer(customer);
    selectedAddress(customer.deliveryCustomerAddresses![0]);
    selectedAddressIdForDropdown(
        selectedAddress.value!.deliveryCustomerAddressId);

    await getDeliveryCustomersAddresses(
        selectedCustomer.value!.deliveryCustomerId!);
  }

  selectAddress(int deliveryCustomerAddressId) async {
    for (var i = 0;
        i < selectedCustomer.value!.deliveryCustomerAddresses!.length;
        i++) {
      var add = selectedCustomer.value!.deliveryCustomerAddresses![i];
      if (add.deliveryCustomerAddressId == deliveryCustomerAddressId) {
        selectedAddress(add);
        selectedAddressIdForDropdown(
            selectedAddress.value!.deliveryCustomerAddressId);
      }
    }
  }

  isAddressSelected(int deliveryCustomerAddressId) {
    return selectedAddress.value!.deliveryCustomerAddressId ==
        deliveryCustomerAddressId;
  }

  isPaymentTypeSelected(int paymentType) {
    return delivery.value!.deliveryPaymentTypeId == paymentType;
  }

  changeDeliveryPaymentType(int? paymentType) async {
    delivery.update((val) {
      val!.deliveryPaymentTypeId = paymentType;
    });
  }

  void changeDeliveryType(int type) {
    selectedDeliveryTimeType(type);
  }

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(selectedDate.value.year),
        lastDate: DateTime(selectedDate.value.year + 1));
    if (picked != null) selectedDate(picked);
  }

  Future selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
        context: Get.context!,
        initialTime: selectedDeliveryTime.value,
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
        confirmText: 'Kaydet',
        cancelText: 'Vazgeç');
    if (picked != null) selectedDeliveryTime(picked);
  }

  addAddress(int deliveryCustomerId, String phoneNumber) async {
    var customer = await deliveryService.getDeliveryCustomerFromId(
        deliveryCustomerId, null);
    DeliveryCustomerModel? res = await Get.dialog(const CustomerDetailPage(),
        arguments: [CustomerDetailPageTypeEnum.ADDRESS, customer, phoneNumber],
        barrierDismissible: false);
    if (res != null) {
      await getDeliveryCustomersAddresses(
          selectedCustomer.value!.deliveryCustomerId!);
      selectAddress(
          res.deliveryCustomerAddresses!.last.deliveryCustomerAddressId!);
    }
  }

  save() {
    if (selectedCustomer.value == null) {
      showSnackbarError('Lütfen müşteri seçiniz!');
    } else if (selectedAddress.value == null) {
      showSnackbarError('Lütfen adres seçiniz!');
    } else {
      var ret = DeliveryDetailSelectionReturnModel(
        delivery: delivery.value!,
        selectedAddress: selectedAddress.value!,
        paymentType: DeliveryPaymentTypeEnum
            .values[delivery.value!.deliveryPaymentTypeId!],
        selectedCustomer: selectedCustomer.value!,
        selectedDeliveryTimeType: selectedDeliveryTimeType.value,
        selectedDate: selectedDate.value,
        selectedDeliveryTime: selectedDeliveryTime.value,
      );
      Get.back(result: ret);
    }
  }
}

class DeliveryDetailSelectionReturnModel {
  final DeliveryCustomerAddressModel selectedAddress;
  final DeliveryModel delivery;
  final DeliveryPaymentTypeEnum paymentType;
  final DeliveryCustomerModel selectedCustomer;
  final int selectedDeliveryTimeType;
  final DateTime selectedDate;
  final TimeOfDay selectedDeliveryTime;

  DeliveryDetailSelectionReturnModel({
    required this.selectedAddress,
    required this.delivery,
    required this.paymentType,
    required this.selectedCustomer,
    required this.selectedDeliveryTimeType,
    required this.selectedDate,
    required this.selectedDeliveryTime,
  });
}
