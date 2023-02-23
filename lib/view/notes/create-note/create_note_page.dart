import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/notes/create-note/create_note_page_view_model.dart';

import '../../../locale_keys_enum.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';

class CreateNotePages extends StatelessWidget {
  final CreateNoteController controller = Get.put(CreateNoteController());

  CreateNotePages({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Obx(() => SizedBox(
              width: 500,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Yeni Not",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 180,
                        child: Text(
                          "Kategoriler: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: Obx(() {
                          return DropdownButton2(
                            isExpanded: true,
                            hint: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Kategoriler',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            items: buildSubCategories(),
                            onChanged: (value) {},
                            buttonHeight: 40,
                            buttonWidth: 300,
                            itemHeight: 30,
                            dropdownWidth: 300,
                            itemPadding: EdgeInsets.zero,
                            value: controller.subCategoryIds.isEmpty
                                ? null
                                : controller.subCategoryIds.last,
                            selectedItemBuilder: (context) {
                              return List.generate(
                                  controller.getSubCategoriesCount(), (index) {
                                return Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    "${controller.subCategoryIds.length} tane seçildi",
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Not: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.noteCtrl,
                          onTap: () async {
                            if (controller.localeManager.getBoolValue(
                                PreferencesKeys.SCREEN_KEYBOARD)) {
                              var res = await showDialog(
                                context: context,
                                builder: (context) => const ScreenKeyboard(),
                              );
                              if (res != null) {
                                controller.noteCtrl.text = res;
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
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
                              // updateAction!(noteController.text);
                              controller.createMenuItemNote();
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

  List<DropdownMenuItem<int>> buildSubCategories() {
    List<DropdownMenuItem<int>> ret = [];

    for (var cat in controller.categories) {
      ret.add(
        DropdownMenuItem(
          value: null,
          enabled: false,
          child: Text(cat.nameTr!),
        ),
      );
      for (var element in cat.menuItemSubCategories!) {
        ret.add(DropdownMenuItem(
          value: element.menuItemSubCategoryId,
          enabled: false,
          child: Obx(() {
            return InkWell(
              onTap: () {
                controller.isSubCategorySelected(element.menuItemSubCategoryId!)
                    ? controller
                        .removeSubCategory(element.menuItemSubCategoryId!)
                    : controller.addSubCategory(element.menuItemSubCategoryId!);
              },
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    controller.isSubCategorySelected(
                            element.menuItemSubCategoryId!)
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 16),
                    Text(
                      element.nameTr!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
      }
    }

    return ret;
  }
}
