import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';

import '../../model/check_model.dart';
import 'create-note/create_note_page.dart';

class NotesPagesController extends BaseController {
  final GroupedCheckItem item = Get.arguments[0];
  final TextEditingController noteController = Get.arguments[1];
  final Function(String note)? updateAction = Get.arguments[2];

  RxList<String> notes = RxList<String>([]);

  MenuService menuService = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotes();
    });
  }

  getNotes() async {
    var res =
        await menuService.getMenuItemNotes(item.originalItem!.menuItemId!);
    if (res != null) {
      notes(res.notes!);
    }
  }

  openAddNote() async {
    await Get.dialog(
      const CreateNotePages(),
      arguments: [item],
    );
  }
}
