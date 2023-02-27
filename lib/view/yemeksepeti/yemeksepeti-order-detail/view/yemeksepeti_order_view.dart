import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/check_model.dart';
import '../../../../model/delivery_model.dart';
import '../viewmodel/yemeksepeti_order_view_model.dart';

class YemeksepetiOrderPage extends StatelessWidget {
  const YemeksepetiOrderPage();

  @override
  Widget build(BuildContext context) {
    YemeksepetiOrderController controller = Get.find();
    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Color(0xffEDEAE6),
        children: [
          Obx(() {
            if (controller.yemeksepetiCheck.value != null) {
              return SizedBox(
                height: context.height * 90 / 100,
                width: context.width * 70 / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 80),
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  controller.getTitleText(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300]),
                                    label: Text('Geri Dön',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 16, 12, 0),
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
                              SizedBox(width: 4),
                              Text(
                                'Müşteri Bilgileri',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            controller.yemeksepetiCheck.value!.vale!
                                ? 'Getir Getirsin'
                                : 'Restoran Getirsin',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.black),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .yemeksepetiCheck.value!.customerName!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Müşteri İletişim: ${controller.yemeksepetiCheck.value!.customerPhoneNumber}',
                                  style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller
                                    .openDeleteYemeksepetiOrderDialog(),
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.delete_forever,
                                      size: 30,
                                    ),
                                    Text('SİSTEMDEN SİL',
                                        style: TextStyle(fontSize: 18))
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => controller.openPrinterDialog(),
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.print,
                                      size: 30,
                                    ),
                                    Text('YAZDIR',
                                        style: TextStyle(fontSize: 18))
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.red[900],
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Adres ve Konum',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.black),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                    .yemeksepetiCheck.value!.customerAddress! +
                                '\n' +
                                controller.yemeksepetiCheck.value!
                                    .customerAddressDefinition!,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text('Ödeme Şekli: ' + controller.getPaymentText(),
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Divider(color: Colors.black),
                    Expanded(
                      flex: 85,
                      child: Obx(() {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 12, 0),
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
                                            Text(item!.getName),
                                            Text(controller.getCondimentText(
                                                item.originalItem!)),
                                            Text(getItemNoteString(
                                                item.originalItem!))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(item.itemCount!
                                                  .toStringAsFixed(0) +
                                              ' ADET'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(item.totalPrice
                                              .toStringAsFixed(2)),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller.groupedItems.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey,
                                  height: 1,
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      flex: 22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: buildTotalPriceText(controller),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              );
            } else {
              return Text(
                'Yükleniyor',
                style: TextStyle(fontSize: 26, color: Colors.white),
              );
            }
          }),
        ]);
  }

  Widget buildTotalPriceText(YemeksepetiOrderController controller) {
    if (controller.yemeksepetiCheck.value!.payments!.discountAmount! > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Toplam Tutar:' +
                controller.yemeksepetiCheck.value!.payments!.checkAmount!
                    .toStringAsFixed(2),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.lineThrough),
          ),
          Text(
            controller.yemeksepetiCheck.value!.payments!.remainingAmount!
                .toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      );
    } else {
      return Text(
        'Toplam Tutar:' +
            controller.yemeksepetiCheck.value!.payments!.checkAmount!
                .toStringAsFixed(2),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }

  String getItemNoteString(CheckMenuItemModel item) {
    if (item.note != null && item.note!.isNotEmpty) {
      return '        ' + item.note!;
    } else {
      return '';
    }
  }

  Widget getConfirmButton(YemeksepetiOrderController controller) {
    switch (controller.yemeksepetiCheck.value!.status) {
      // case 325:
      //   return GetirConfirmButton(
      //     text: 'Ön Onayla',
      //     icon: Icons.check,
      //     callback: () => value.verifyScheduledGetirOrder(),
      //   );
      // case 350:
      //   return Container();
      case 0:
        return GetirConfirmButton(
          text: 'Onayla',
          icon: Icons.check,
          callback: () => controller.verifyYemeksepetiOrder(),
        );
      case 1:
        // if (value.getirCheck!.getirGetirsin!)
        //   return GetirConfirmButton(
        //     text: 'Hazırlandı',
        //     icon: Icons.check,
        //     callback: () => value.prepareGetirOrder(),
        //   );
        return GetirConfirmButton(
          text: 'Yola Çıkar',
          icon: Icons.motorcycle,
          callback: () => controller.prepareYemeksepetiOrder(),
        );
      // case 550:
      //   return GetirConfirmButton(
      //     text: 'Kuryeye Teslim Et',
      //     icon: Icons.motorcycle,
      //     callback: () => value.handoverGetirOrder(),
      //   );
      case 600:
        return Container();
      case 4:
        return GetirConfirmButton(
          text: 'Teslim Et',
          icon: Icons.check,
          callback: () => controller.deliverYemeksepetiOrder(),
        );
      case 5:
        if (controller.yemeksepetiCheck.value!.deliveryStatusTypeId ==
            DeliveryStatusTypeEnum.Delivered.index) {
          return GetirConfirmButton(
            text: 'Ödeme Al',
            icon: Icons.check,
            callback: () => controller.navigateToDeliveryOrder(
                controller.yemeksepetiCheck.value!.checkId, true),
          );
        } else {
          return Container();
        }
      default:
        return Container();
    }
  }
}

class GetirConfirmButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? callback;

  const GetirConfirmButton({this.text, this.callback, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        callback!();
      },
      icon: Icon(icon),
      label: Text(
        text!,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
    );
  }
}
