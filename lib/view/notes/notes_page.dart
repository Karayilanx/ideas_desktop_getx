import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/locale_keys_enum.dart';
import 'package:ideas_desktop_getx/view/notes/notes_page_view_model.dart';

import '../_utility/screen_keyboard/screen_keyboard_view.dart';

class NotesPages extends StatelessWidget {
  const NotesPages({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesPagesController controller = Get.put(NotesPagesController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Obx(() => SizedBox(
              width: 700,
              height: controller.notes.isNotEmpty ? 600 : 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: context.theme.primaryColor,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            'Ürün\n${controller.item.itemCount!} - ${controller.item.originalItem!.getName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () => controller.openAddNote(),
                            child: const Text(
                              "Not Ekle",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: controller.noteController,
                      onTap: () async {
                        if (controller.localeManager
                            .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                          var res = await showDialog(
                            context: context,
                            builder: (context) => const ScreenKeyboard(),
                          );
                          if (res != null) {
                            controller.noteController.text = res;
                          }
                        }
                      },
                      style: const TextStyle(fontSize: 22),
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          filled: true,
                          hintText: 'Bu alana notalarınızı girebilirsiniz',
                          fillColor: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      crossAxisCount: 4,
                      childAspectRatio: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: createNotes(controller),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.updateAction!(
                                  controller.noteController.text);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                backgroundColor: const Color(0xffF1A159),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8)),
                            child: const Text(
                              'Kaydet',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8)),
                            child: const Text(
                              'Vazgeç',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ))
      ],
    );
  }

  List<Widget> createNotes(NotesPagesController controller) {
    List<Widget> ret = [];

    if (controller.notes.isNotEmpty) {
      ret.addAll(List.generate(
        controller.notes.length,
        (index) {
          return ElevatedButton(
              onPressed: () => controller.noteController.text +=
                  "${controller.notes[index]} ",
              child: Text(controller.notes[index]));
        },
      ));
    }

    return ret;
  }
}
