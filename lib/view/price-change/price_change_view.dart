import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/_utility/screen_keyboard/screen_keyboard_view.dart';
import 'package:ideas_desktop_getx/view/price-change/price_change_table.dart';
import 'package:ideas_desktop_getx/view/price-change/price_change_view_model.dart';

import '../../locale_keys_enum.dart';

class PriceChangePage extends StatelessWidget {
  const PriceChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    PriceChangeController controller = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: controller.menuDataSource.value != null
              ? buildBody(controller)
              : const LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(PriceChangeController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Ürün ara',
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
                          const ScreenKeyboard(),
                        );
                        if (res != null) {
                          controller.searchCtrl.text = res;
                          controller.filterMenuItems();
                        }
                      }
                    },
                    onChanged: (v) => {
                          controller.filterMenuItems(),
                        }),
              ),
            ),
            GestureDetector(
              onTap: () => controller.savePriceChange(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Kaydet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            color: Colors.white,
            child: buildCancelReportTable(controller),
          ),
        ),
      ],
    );
  }

  Widget buildCancelReportTable(PriceChangeController controller) {
    return Obx(() {
      return PriceChangeTable(
        source: controller.menuDataSource.value!,
      );
    });
  }
}
