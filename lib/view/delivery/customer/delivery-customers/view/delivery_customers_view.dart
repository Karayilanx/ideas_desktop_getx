import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/_utility/screen_keyboard/screen_keyboard_view.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/delivery-customers/delivery_customers_table.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/delivery-customers/viewmodel/delivery_customers_view_model.dart';

import '../../../../../locale_keys_enum.dart';

class DeliveryCustomersPage extends StatelessWidget {
  const DeliveryCustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeliveryCustomersController controller = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: controller.deliveryCustomersDataSource != null
              ? buildBody(controller)
              : LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(DeliveryCustomersController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Müşteri ara (Telefon veya İsim)',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    controller: controller.searchCtrl,
                    onTap: () async {
                      if (controller.localeManager
                          .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                        var res = await Get.dialog(
                          ScreenKeyboard(),
                        );
                        if (res != null) {
                          controller.searchCtrl.text = res;
                          controller.filterCustomers();
                        }
                      }
                    },
                    onChanged: (v) => {
                          controller.filterCustomers(),
                        }),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await controller.addCustomer();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Yeni Müşteri',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: buildCancelReportTable(controller),
          ),
        ),
      ],
    );
  }

  Widget buildCancelReportTable(DeliveryCustomersController controller) {
    return Obx(() {
      return DeliveryCustomersTable(
        source: controller.deliveryCustomersDataSource.value!,
      );
    });
  }
}
