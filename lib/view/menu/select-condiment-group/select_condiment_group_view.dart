import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/_utility/screen_keyboard/screen_keyboard_view.dart';
import 'package:ideas_desktop_getx/view/menu/select-condiment-group/select_condiment_group_view_model.dart';
import 'package:ideas_desktop_getx/view/menu/select-condiment-group/select_condiment_table.dart';
import 'package:ideas_desktop_getx/view/select-condiment/viewmodel/select_condiment_view_model.dart';

import '../../../locale_keys_enum.dart';

class SelectCondimentGroupPage extends StatelessWidget {
  const SelectCondimentGroupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SelectCondimentGroupController controller =
        Get.put(SelectCondimentGroupController());
    return SafeArea(
      child: Obx(() {
        return !controller.showLoading.value &&
                controller.selectCondimentDataSource.value != null
            ? buildBody(controller)
            : LoadingPage();
      }),
    );
  }

  Widget buildBody(SelectCondimentGroupController controller) {
    return Dialog(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.transparent,
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: TextFormField(
                      controller: controller.searchCtrl,
                      onTap: () async {
                        if (controller.localeManager
                            .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                          var res = await Get.dialog(
                            ScreenKeyboard(),
                          );
                          if (res != null) {
                            controller.searchCtrl.text = res;
                            controller.filterCondimentGroups();
                          }
                        }
                      },
                      onChanged: (v) => {
                        controller.filterCondimentGroups(),
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        hintText: 'Arama...',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.saveSelection(),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        'Kaydet',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.openNewCondimentGroupDialog(),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        'Yeni Ekseçim Grubu',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.closePage(),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        'Kapat',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildSelectCondimentTable(controller),
        ],
      ),
    );
  }

  Widget buildSelectCondimentTable(SelectCondimentGroupController controller) {
    return Obx(() {
      return Expanded(
        child: SelectCondimentTable(
          source: controller.selectCondimentDataSource.value!,
        ),
      );
    });
  }
}
