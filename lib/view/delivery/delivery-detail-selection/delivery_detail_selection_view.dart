import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/delivery/delivery-detail-selection/delivery_detail_selection_view_model.dart';
import 'package:intl/intl.dart';

import '../../../model/delivery_model.dart';
import '../../order-detail/component/menu_item_category_button.dart';

class DeliveryDetailSelectionPage extends StatelessWidget {
  const DeliveryDetailSelectionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeliveryDetailSelectionController controller = Get.find();
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: 800,
          height: 600,
          child: Obx(() {
            return Scaffold(body: buildBody(controller));
          }),
        )
      ],
    );
  }

  Widget buildBody(DeliveryDetailSelectionController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                controller.save();
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Kaydet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Kapat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: buildPageDetails(controller),
          ),
        ),
      ],
    );
  }

  Widget buildPageDetails(DeliveryDetailSelectionController controller) {
    return Obx(() {
      return Column(
        children: [
          buildCustomerDetailsRow(controller),
          const SizedBox(height: 20),
          buildCustomerAddressDetails(controller),
          buildPaymentInformationRow(controller),
          Padding(
              padding: const EdgeInsets.fromLTRB(60, 20, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Servis Zamanı',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(color: Colors.black),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          MenuItemCategoryButton(
                            callback: () => controller.changeDeliveryType(0),
                            selected:
                                controller.selectedDeliveryTimeType.value == 0,
                            text: 'Hemen',
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                          ),
                          MenuItemCategoryButton(
                            callback: () => controller.changeDeliveryType(1),
                            selected:
                                controller.selectedDeliveryTimeType.value == 1,
                            text: 'İleri Zamanlı',
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                          ),
                        ],
                      ),
                    ),
                    if (controller.selectedDeliveryTimeType.value == 1)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            buildDateInput(controller),
                            buildTimeInput(controller)
                          ],
                        ),
                      ),
                  ])),
        ],
      );
    });
  }

  Padding buildPaymentInformationRow(
      DeliveryDetailSelectionController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ödeme Şekli',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(color: Colors.black),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                MenuItemCategoryButton(
                  callback: () => controller.changeDeliveryPaymentType(
                      DeliveryPaymentTypeEnum.Cash.index),
                  selected: controller.isPaymentTypeSelected(
                      DeliveryPaymentTypeEnum.Cash.index),
                  text: 'Nakit',
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                ),
                MenuItemCategoryButton(
                  callback: () => controller.changeDeliveryPaymentType(
                      DeliveryPaymentTypeEnum.CreditCard.index),
                  selected: controller.isPaymentTypeSelected(
                      DeliveryPaymentTypeEnum.CreditCard.index),
                  text: 'Kredi Kartı',
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                ),
                MenuItemCategoryButton(
                  callback: () => controller.changeDeliveryPaymentType(
                      DeliveryPaymentTypeEnum.Account.index),
                  selected: controller.isPaymentTypeSelected(
                      DeliveryPaymentTypeEnum.Account.index),
                  text: 'Cari',
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                ),
                MenuItemCategoryButton(
                  callback: () => controller.changeDeliveryPaymentType(
                      DeliveryPaymentTypeEnum.Other.index),
                  selected: controller.isPaymentTypeSelected(
                      DeliveryPaymentTypeEnum.Other.index),
                  text: 'Diğer',
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildCustomerAddressDetails(
      DeliveryDetailSelectionController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          size: 40,
          color: Colors.black,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.selectedCustomer.value != null)
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: createDeliveryAdressButtons(controller),
                      // itemBuilder: (context, index) {
                      //   DeliveryCustomerAddressModel address = value
                      //       .selectedCustomer!
                      //       .deliveryCustomerAddresses![index];
                      //   return Observer(builder: (_) {
                      //     return SizedBox(
                      //       height: 70,
                      //       child: MenuItemCategoryButton(
                      //         callback: () => value.selectAddress(
                      //             address.deliveryCustomerAddressId!),
                      //         selected: value.isAddressSelected(
                      //             address.deliveryCustomerAddressId!),
                      //         text: address.addressTitle,
                      //         margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
                      //       ),
                      //     );
                      //   });
                      // },
                      // itemCount: value
                      //     .selectedCustomer!.deliveryCustomerAddresses!.length,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            SizedBox(
              width: Get.context!.width * 40 / 100,
              child: Obx(() {
                return Text(
                  controller.selectedCustomer.value != null
                      ? '${controller.selectedAddress.value!.address!}\n${controller.selectedAddress.value!.addressDefinition!}'
                      : 'Müşteri Seçiniz',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              }),
            )
          ],
        ),
      ],
    );
  }

  List<Widget> createDeliveryAdressButtons(
      DeliveryDetailSelectionController controller) {
    List<Widget> ret = [];
    for (var element
        in controller.selectedCustomer.value!.deliveryCustomerAddresses!) {
      ret.add(Obx(() {
        return SizedBox(
          height: 70,
          child: MenuItemCategoryButton(
            callback: () =>
                controller.selectAddress(element.deliveryCustomerAddressId!),
            selected: controller
                .isAddressSelected(element.deliveryCustomerAddressId!),
            text: element.addressTitle,
            margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
          ),
        );
      }));
    }
    ret.add(SizedBox(
      height: 70,
      child: MenuItemCategoryButton(
        callback: () => controller.addAddress(
            controller.selectedCustomer.value!.deliveryCustomerId!,
            controller.selectedCustomer.value!.phoneNumber!),
        selected: false,
        text: "Adres Ekle",
        margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
      ),
    ));
    return ret;
  }

  Row buildCustomerDetailsRow(DeliveryDetailSelectionController controller) {
    return Row(
      children: [
        const Icon(
          Icons.person,
          color: Colors.black,
          size: 40,
        ),
        const SizedBox(width: 20),
        if (controller.selectedCustomer.value != null)
          Text(
            '${controller.selectedCustomer.value!.name!} ${controller.selectedCustomer.value!.lastName!}\n${controller.selectedCustomer.value!.phoneNumber!}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        if (controller.selectedCustomer.value != null)
          const SizedBox(width: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              var res =
                  await Get.toNamed('delivery-customer-page', arguments: true);

              controller.selectCustomer(res);
            },
            child: const Text(
              'Müşteri Seç/Ekle',
            ))
      ],
    );
  }

  Widget buildTimeInput(DeliveryDetailSelectionController controller) {
    return GestureDetector(
      onTap: () => controller.selectTime(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 80),
        child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
                  '${controller.selectedDeliveryTime.value.hour} : ${controller.selectedDeliveryTime.value.minute}',
                  style: const TextStyle(fontSize: 22))),
        ),
      ),
    );
  }

  Widget buildDateInput(DeliveryDetailSelectionController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectDate();
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 130),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
                  DateFormat('dd.MM.yyyy')
                      .format(controller.selectedDate.value),
                  style: const TextStyle(fontSize: 22))),
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildAddressDropdown(
      DeliveryDetailSelectionController controller) {
    List<DropdownMenuItem> ret = [];

    if (controller.selectedCustomer.value != null) {
      for (var i = 0;
          i <
              controller
                  .selectedCustomer.value!.deliveryCustomerAddresses!.length;
          i++) {
        var add =
            controller.selectedCustomer.value!.deliveryCustomerAddresses![i];
        ret.add(DropdownMenuItem(
          value: add.deliveryCustomerAddressId,
          child: Text(
            add.addressTitle!,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ));
      }
    }

    return ret;
  }
}
