import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../locale_keys_enum.dart';
import '../../../theme/theme.dart';
import '../../_utility/loading/loading_screen.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'yemeksepeti_cancel_view_model.dart';

class YemeksepetiCancelPage extends StatelessWidget {
  const YemeksepetiCancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    YemeksepetiCancelController controller =
        Get.put(YemeksepetiCancelController());
    return buildBody(controller);
  }

  SimpleDialog buildBody(YemeksepetiCancelController controller) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        Obx(() => SizedBox(
              height: 300,
              child: controller.cancelOptions.isNotEmpty
                  ? const LoadingPage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.red,
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Sipariş İptal',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                          child: Row(
                            children: [
                              const Text(
                                'İptal Sebebi: ',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16),
                                  child: DropdownButton(
                                    icon: const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                                    items: getCancelButtons(controller),
                                    value: controller.selectedReasonId.value,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    onChanged: (dynamic newGroup) {
                                      controller.changeSelectedReason(newGroup);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            controller: controller.ctrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Açıklama',
                              isDense: true,
                            ),
                            style: const TextStyle(),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const Spacer(),
                            Expanded(
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                child: ElevatedButton(
                                  onPressed: () => controller.save(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ideasTheme.scaffoldBackgroundColor),
                                  child: const Text(
                                    'KAYDET',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    'Vazgeç',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ))
      ],
    );
  }
}

Widget buildTableGroupsDropdown(YemeksepetiCancelController controller) {
  return Obx(
    () => Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Hesap Tipi: ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            child: DropdownButton(
              icon: const Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              items: getCancelButtons(controller),
              value: controller.selectedReasonId.value,
              style: const TextStyle(color: Colors.black, fontSize: 22),
              onChanged: (dynamic newGroup) {
                controller.changeSelectedReason(newGroup);
              },
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller.ctrl,
            onTap: () async {
              if (controller.localeManager
                  .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                var res = await Get.dialog(
                  const ScreenKeyboard(),
                );
                if (res != null) {
                  controller.ctrl.text = res;
                }
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: 'Açıklama',
              isDense: true,
            ),
            style: const TextStyle(),
          ),
        ),
        ElevatedButton(
            onPressed: () => controller.save(), child: const Text('KAYDET'))
      ],
    ),
  );
}

List<DropdownMenuItem> getCancelButtons(
    YemeksepetiCancelController controller) {
  List<DropdownMenuItem> items = [];
  for (var item in controller.cancelOptions) {
    items.add(DropdownMenuItem(
      value: item.reasonId,
      child: Text(
        item.reasonName!,
      ),
    ));
  }
  return items;
}
