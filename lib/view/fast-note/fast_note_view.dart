import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../locale_keys_enum.dart';
import '../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'fast_note_view_model.dart';

class FastNotePage extends StatelessWidget {
  const FastNotePage({super.key});
  @override
  Widget build(BuildContext context) {
    final FastNoteController controller = Get.put(FastNoteController());
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: buildBody(controller),
      ),
    );
  }

  Widget buildBody(FastNoteController controller) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (text) {
                    controller.filterNotes(text);
                  },
                  controller: controller.searchCtrl,
                  onTap: () async {
                    if (controller.localeManager
                        .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                      var res = await Get.dialog(
                        const ScreenKeyboard(),
                      );
                      if (res != null) {
                        controller.searchCtrl.text = res;
                        controller.filterNotes(res);
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
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Arama',
                  ),
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Vazgeç',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: Obx(() {
              return GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                crossAxisCount: 6,
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: createNotes(controller),
              );
            }),
          ),
        ),
      ],
    );
  }

  List<Widget> createNotes(FastNoteController controller) {
    if (controller.filteredNotes.isNotEmpty) {
      return List.generate(
        controller.filteredNotes.length,
        (index) {
          return ElevatedButton(
              onPressed: () =>
                  Get.back(result: controller.filteredNotes[index].note!),
              child: Text(controller.filteredNotes[index].note!));
        },
      );
    } else {
      return [];
    }
  }
}
