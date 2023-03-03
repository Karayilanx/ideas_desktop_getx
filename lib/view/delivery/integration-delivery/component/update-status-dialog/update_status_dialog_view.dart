import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_utility/loading/loading_screen.dart';
import '../../../../_utility/service_helper.dart';
import 'update_status_dialog_view_model.dart';

class UpdateStatusDialog extends StatelessWidget with ServiceHelper {
  UpdateStatusDialog({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateStatusDialogController controller =
        Get.put(UpdateStatusDialogController());
    return Obx(
      () => controller.getirCheck.value != null ||
              controller.yemeksepetiCheck.value != null
          // controller.fuudyCheck != null
          ? buildBody(controller)
          : const LoadingPage(),
    );
  }

  Widget buildBody(UpdateStatusDialogController controller) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0),
      children: [
        Container(
          width: Get.context!.width * 70 / 100,
          height: Get.context!.height * 70 / 100,
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.green,
                padding: const EdgeInsets.all(20),
                child: Text(
                  controller.getirCheck.value != null
                      ? controller.getTitleTextForDialogGetir(
                          controller.getirCheck.value!)
                      : controller.yemeksepetiCheck.value != null
                          ? controller.getTitleTextForDialogYemeksepeti(
                              controller.yemeksepetiCheck.value!)
                          // : controller.fuudyCheck != null
                          //     ? value
                          //         .getTitleTextForDialogFuudy(value.fuudyCheck!)
                          : 'HATA',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCustomerName(controller),
                    const SizedBox(height: 10),
                    buildAddress(controller),
                    const SizedBox(height: 10),
                    buildTotalPriceText(controller),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 4),
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPaymentString(controller),
                    const SizedBox(height: 4),
                    buildDeliveryType(controller),
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(right: 10),
                child: buildButtons(controller),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildButtons(UpdateStatusDialogController controller) {
    if (controller.getirCheck.value != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: controller.getStatusButtonsForDialog(
          statusId: controller.getirCheck.value!.deliveryStatusTypeId!,
          value: controller,
          getirId: controller.getirId,
          yemeksepetiId: controller.yemeksepetiId,
          getirStatus: controller.getirCheck.value!.status,
          checkId: controller.getirCheck.value!.checkId,
          isVale: false,
          getirGetirsin: controller.getirCheck.value!.getirGetirsin!,
          fuudyId: controller.fuudyId,
        ),
      );
    } else if (controller.yemeksepetiCheck.value != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: controller.getStatusButtonsForDialog(
          statusId: controller.yemeksepetiCheck.value!.deliveryStatusTypeId!,
          value: controller,
          getirId: controller.getirId,
          yemeksepetiId: controller.yemeksepetiId,
          getirStatus: null,
          checkId: controller.yemeksepetiCheck.value!.checkId,
          isVale: controller.isVale,
          getirGetirsin: false,
          fuudyId: controller.fuudyId,
        ),
      );
    }
    // else if (value.fuudyCheck != null) {
    //   return Row(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: value.getStatusButtonsForDialog(
    //       statusId: value.fuudyCheck!.deliveryStatusTypeId!,
    //       value: value,
    //       getirId: getirId,
    //       yemeksepetiId: yemeksepetiId,
    //       getirStatus: null,
    //       checkId: value.fuudyCheck!.checkId,
    //       context: value.buildContext!,
    //       isVale: isVale,
    //       getirGetirsin: false,
    //       fuudyId: fuudyId,
    //     ),
    //   );
    // }
    else {
      return Container();
    }
  }

  Widget buildDeliveryType(UpdateStatusDialogController controller) {
    if (controller.getirCheck.value != null) {
      return Text(
        controller.getirCheck.value!.getirGetirsin!
            ? 'Getir Getirsin'
            : 'Restoran Getirsin',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.red,
        ),
      );
    } else if (controller.yemeksepetiCheck.value != null) {
      return Text(
        controller.yemeksepetiCheck.value!.vale! ? 'Vale' : 'Restoran Getirsin',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.red,
        ),
      );
    }
    // else if (value.fuudyCheck != null) {
    //   return Text(
    //     value.fuudyCheck!.isRestaurantCourier!
    //         ? 'Restoran Kurye'
    //         : 'Fuudy Kurye',
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 18,
    //       color: Colors.red,
    //     ),
    //   );
    // }
    else {
      return Container();
    }
  }

  Widget buildPaymentString(UpdateStatusDialogController controller) {
    if (controller.getirCheck.value != null) {
      return Text(
        controller.getirCheck.value!.paymentTypeString!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (controller.yemeksepetiCheck.value != null) {
      return Text(
        controller.yemeksepetiCheck.value!.paymentTypeString!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }
    //  else if (value.fuudyCheck != null) {
    //   return Text(
    //     value.fuudyCheck!.paymentTypeString!,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 18,
    //     ),
    //   );
    // }
    else {
      return Container();
    }
  }

  Widget buildAddress(UpdateStatusDialogController controller) {
    if (controller.getirCheck.value != null) {
      return Text(
        '${controller.getirCheck.value!.customerAddress!} - ${controller.getirCheck.value!.customerAddressDefinition!}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (controller.yemeksepetiCheck.value != null) {
      return Text(
        '${controller.yemeksepetiCheck.value!.customerAddress!} - ${controller.yemeksepetiCheck.value!.customerAddressDefinition!}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }
    // else if (value.fuudyCheck != null) {
    //   return Text(
    //     value.fuudyCheck!.customerAddress! +
    //         ' - ' +
    //         value.fuudyCheck!.customerAddressDefinition!,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 18,
    //     ),
    //   );
    // }
    else {
      return Container();
    }
  }

  Widget buildCustomerName(UpdateStatusDialogController controller) {
    if (controller.getirCheck.value != null) {
      return Text(
        '${controller.getirCheck.value!.customerName!} - ${controller.getirCheck.value!.customerPhoneNumber!}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (controller.yemeksepetiCheck.value != null) {
      return Text(
        '${controller.yemeksepetiCheck.value!.customerName!} - ${controller.yemeksepetiCheck.value!.customerPhoneNumber!}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }
    // else if (value.fuudyCheck != null) {
    //   return Text(
    //     value.fuudyCheck!.customerName! +
    //         ' - ' +
    //         value.fuudyCheck!.customerPhoneNumber!,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 18,
    //     ),
    //   );
    // }
    else {
      return Container();
    }
  }
}

Widget buildTotalPriceText(UpdateStatusDialogController controller) {
  if (controller.getirCheck.value != null) {
    if (controller.getirCheck.value!.payments!.discountAmount! > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Toplam Tutar:${controller.getirCheck.value!.payments!.checkAmount!.toStringAsFixed(2)}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.lineThrough),
          ),
          Text(
            controller.getirCheck.value!.payments!.remainingAmount!
                .toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      );
    } else {
      return Text(
        'Toplam Tutar:${controller.getirCheck.value!.payments!.checkAmount!.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  } else if (controller.yemeksepetiCheck.value != null) {
    if (controller.yemeksepetiCheck.value!.payments!.discountAmount! > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Toplam Tutar:${controller.yemeksepetiCheck.value!.payments!.checkAmount!.toStringAsFixed(2)}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.lineThrough),
          ),
          Text(
            controller.yemeksepetiCheck.value!.payments!.remainingAmount!
                .toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      );
    } else {
      return Text(
        'Toplam Tutar:${controller.yemeksepetiCheck.value!.payments!.checkAmount!.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }
  // else if (value.fuudyCheck != null) {
  //   if (value.fuudyCheck!.payments!.discountAmount! > 0) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Text(
  //           'Toplam Tutar:' +
  //               value.fuudyCheck!.payments!.checkAmount!.toStringAsFixed(2),
  //           style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 20,
  //               decoration: TextDecoration.lineThrough),
  //         ),
  //         Text(
  //           value.fuudyCheck!.payments!.remainingAmount!.toStringAsFixed(2),
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //         ),
  //       ],
  //     );
  //   }
  //   else {
  //     return Text(
  //       'Toplam Tutar:' +
  //           value.fuudyCheck!.payments!.checkAmount!.toStringAsFixed(2),
  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //     );
  //   }
  // }
  else {
    return Container();
  }
}
