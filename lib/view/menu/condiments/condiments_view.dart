import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/_utility/screen_keyboard/screen_keyboard_view.dart';
import 'package:ideas_desktop_getx/view/menu/condiments/condiments_table.dart';
import 'package:ideas_desktop_getx/view/menu/condiments/condiments_view_model.dart';

import '../../../locale_keys_enum.dart';

class CondimentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CondimentsController controller = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: !controller.showLoading.value &&
                  controller.condimentsDataSource.value != null
              ? buildBody(controller)
              : LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(CondimentsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Ekseçim ara',
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
                          controller.filterCondiments();
                        }
                      }
                    },
                    onChanged: (v) => {
                          controller.filterCondiments(),
                        }),
              ),
            ),
            GestureDetector(
              onTap: () => controller.openNewCondimentDialog(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Yeni Ekseçim',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(fontSize: 24),
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
            color: Colors.white,
            child: buildCancelReportTable(controller),
          ),
        ),
      ],
    );
  }

  Widget buildCancelReportTable(CondimentsController controller) {
    return Obx(() {
      return CondimentsTable(
        source: controller.condimentsDataSource.value!,
      );
    });
  }
}
