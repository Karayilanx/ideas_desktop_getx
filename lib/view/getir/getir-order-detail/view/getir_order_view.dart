import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/getir/getir-order-detail/viewmodel/getir_order_view_model.dart';
import '../../../../model/check_model.dart';
import '../../../_utility/loading/loading_screen.dart';

class GetirOrderPage extends StatelessWidget {
  const GetirOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    GetirOrderController controller = Get.put(GetirOrderController());
    return Obx(
      () => controller.getirCheck.value != null
          ? buildBody(controller, context)
          : const LoadingPage(),
    );
  }

  SimpleDialog buildBody(
      GetirOrderController controller, BuildContext context) {
    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color(0xffEDEAE6),
        children: [
          SizedBox(
            height: context.height * 95 / 100,
            width: context.width * 70 / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              controller.getTitleText(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300]),
                            label: const Text('Geri Dön',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.red[900],
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Müşteri Bilgileri',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        controller.getirCheck.value!.getirGetirsin!
                            ? 'Getir Getirsin'
                            : 'Restoran Getirsin',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.getirCheck.value!.customerName!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'Müşteri İletişim: ${controller.getirCheck.value!.customerPhoneNumber}',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      GestureDetector(
                        onTap: () => controller.openPrinterDialog(),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.print,
                              size: 30,
                            ),
                            Text(
                              'YAZDIR',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red[900],
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Adres ve Konum',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${controller.getirCheck.value!.customerAddress!}\n${controller.getirCheck.value!.customerAddressDefinition!}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ödeme Şekli: ${controller.getPaymentText()}',
                              style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Not: ${controller.getirCheck.value!.checkNote!}',
                              style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black),
                Expanded(
                  flex: 85,
                  child: Obx(() {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var item = controller.groupedItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item.getName),
                                        Text(controller.getCondimentText(
                                            item.originalItem!)),
                                        Text(getItemNoteString(
                                            item.originalItem!))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '${item.itemCount!.toStringAsFixed(0)} ADET'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(item.totalPrice.toStringAsFixed(2)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: controller.groupedItems.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.grey,
                              height: 1,
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Expanded(
                  flex: 22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: buildTotalPriceText(controller),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16)
              ],
            ),
          )
        ]);
  }

  Widget buildTotalPriceText(GetirOrderController controller) {
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
          Expanded(
            child: Text(
              controller.getirCheck.value!.payments!.remainingAmount!
                  .toStringAsFixed(2),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Toplam Tutar:${controller.getirCheck.value!.payments!.checkAmount!.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }

  String getItemNoteString(CheckMenuItemModel item) {
    if (item.note != null && item.note!.isNotEmpty) {
      return '      Not: ${item.note!}';
    } else {
      return '';
    }
  }
}
