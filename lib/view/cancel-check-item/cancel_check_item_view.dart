import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locale_keys_enum.dart';
import '../../locale_manager.dart';
import '../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'cancel_check_item_view_model.dart';
import '../order-detail/component/edit_action_button.dart';

class CancelCheckItemPage extends StatelessWidget {
  final CancelCheckItemController controller = Get.find();

  CancelCheckItemPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: context.width * 30 / 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: context.theme.primaryColor,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Ürün İptali',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() {
                  return TextFormField(
                    controller: controller.cancelNoteController,
                    onTap: () async {
                      if (LocaleManager.instance
                          .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                        var res = await showDialog(
                          context: context,
                          builder: (context) => const ScreenKeyboard(),
                        );
                        if (res != null) {
                          controller.cancelNoteController.text = res;
                        }
                      }
                    },
                    enabled: true,
                    autofocus: true,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  );
                }),
              ),
              Obx(() {
                return CheckboxListTile(
                  value: controller.save.value,
                  title: const Text('Notu hızlı notlara kaydet'),
                  onChanged: (val) {
                    controller.save(val!);
                  },
                );
              }),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: EditActionButton(
                  callback: () => controller.openFastNotesDialog(),
                  text: 'HAZIR NOTLAR',
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: EditActionButton(
                  callback: () => controller.cancelCheckItem(0),
                  text: 'İPTAL',
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: EditActionButton(
                  callback: () => controller.cancelCheckItem(1),
                  text: 'ZAYİ',
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: EditActionButton(
                  callback: () {
                    Navigator.pop(context, null);
                  },
                  text: 'VAZGEÇ',
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }
}
