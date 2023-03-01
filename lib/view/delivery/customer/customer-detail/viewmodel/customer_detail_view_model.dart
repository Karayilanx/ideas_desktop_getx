import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../../../../model/delivery_model.dart';
import '../../../../../service/delivery/delivery_service.dart';
import '../model/customer_detail_page_enum.dart';

class CustomerDetailController extends BaseController {
  final CustomerDetailPageTypeEnum type = Get.arguments[0];
  final DeliveryCustomerModel? customer = Get.arguments[1];
  final String? phoneNumber = Get.arguments[2];

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController lastnameCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController addressTitleCtrl = TextEditingController();
  TextEditingController addressDefinitionCtrl = TextEditingController();
  FocusNode customerNameFocusNode = FocusNode();

  DeliveryService deliveryService = Get.find();

  @override
  void onInit() {
    super.onInit();
    if (type == CustomerDetailPageTypeEnum.EDIT) {
      nameCtrl.text = customer!.name!;
      lastnameCtrl.text = customer!.lastName!;
      addressCtrl.text = customer!.deliveryCustomerAddresses![0].address!;
      addressDefinitionCtrl.text =
          customer!.deliveryCustomerAddresses![0].addressDefinition!;
      addressTitleCtrl.text =
          customer!.deliveryCustomerAddresses![0].addressTitle!;
      phoneNumberCtrl.text = customer!.phoneNumber!;
    } else if (type == CustomerDetailPageTypeEnum.ADDRESS) {
      nameCtrl.text = customer!.name!;
      lastnameCtrl.text = customer!.lastName!;
      phoneNumberCtrl.text = customer!.phoneNumber!;
    } else if (phoneNumber != null) {
      phoneNumberCtrl.text = phoneNumber!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      customerNameFocusNode.requestFocus();
    });
  }

  Future createDeliveryCustomer() async {
    if (nameCtrl.text.isEmpty) {
      showSnackbarError('Müşteri ismi zorunludur.');
      return;
    } else if (phoneNumberCtrl.text.isEmpty) {
      showSnackbarError('Telefon numarası zorunludur.');
      return;
    } else if (addressCtrl.text.isEmpty) {
      showSnackbarError('Adres zorunludur.');
      return;
    }

    DeliveryCustomerModel inp = DeliveryCustomerModel(
      brandId: authStore.user!.branchId!,
      lastName: lastnameCtrl.text,
      name: nameCtrl.text,
      deliveryCustomerAddresses: [],
      phoneNumber: phoneNumberCtrl.text,
    );

    if (type == CustomerDetailPageTypeEnum.NEW ||
        type == CustomerDetailPageTypeEnum.ADDRESS) {
      inp.deliveryCustomerAddresses!.add(DeliveryCustomerAddressModel(
        address: addressCtrl.text,
        addressDefinition: addressDefinitionCtrl.text,
        addressTitle: addressTitleCtrl.text,
      ));
    } else if (type == CustomerDetailPageTypeEnum.EDIT) {
      var address = customer!.deliveryCustomerAddresses![0];

      inp.deliveryCustomerAddresses!.add(DeliveryCustomerAddressModel(
        address: addressCtrl.text,
        addressDefinition: addressDefinitionCtrl.text,
        addressTitle: addressTitleCtrl.text,
        deliveryCustomerAddressId: address.deliveryCustomerAddressId,
      ));
    }

    if (customer != null && customer!.deliveryCustomerId != null) {
      inp.deliveryCustomerId = customer!.deliveryCustomerId!;
    }

    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await deliveryService.createDeliveryCustomer(inp);
    EasyLoading.dismiss();
    if (res != null) {
      Get.back(result: res);
    }
  }
}
