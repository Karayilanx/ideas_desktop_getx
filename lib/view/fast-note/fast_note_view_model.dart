import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../model/cancel_note_model.dart';
import '../../service/check/check_service.dart';

class FastNoteController extends BaseController {
  CheckService checkService = Get.find();
  TextEditingController searchCtrl = TextEditingController();
  RxList<CancelNoteOutput> notes = RxList<CancelNoteOutput>([]);
  RxList<CancelNoteOutput> filteredNotes = RxList<CancelNoteOutput>([]);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotes();
    });
  }

  Future getNotes() async {
    notes(await checkService.getCancelNotes(authStore.user!.branchId!));
    if (notes == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    } else {
      filteredNotes(notes);
    }
  }

  void filterNotes(String text) {
    if (text == '') {
      filteredNotes(notes);
    } else {
      filteredNotes(filteredNotes
          .where((element) =>
              element.note!.toUpperCase().contains(text.toUpperCase()))
          .toList());
    }
  }
}
