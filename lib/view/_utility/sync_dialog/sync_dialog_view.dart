import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/_utility/sync_dialog/sync_dialog_controller.dart';

import 'sync_state_enum.dart';

class SyncDialog extends StatelessWidget {
  const SyncDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final SyncDialogController syncDialogController =
        Get.put(SyncDialogController());
    return Obx(
      () => AlertDialog(
        title: const Text('Güncelleme'),
        content: Row(
          children: [
            buildContentIcon(syncDialogController),
            Text(buildContextText(syncDialogController)),
          ],
        ),
        actions: [
          if (syncDialogController.state.value == SyncState.FAILED ||
              syncDialogController.state.value == SyncState.NEW)
            ElevatedButton(
              onPressed: () => syncDialogController.syncChanges(),
              child: const Text('Güncelle'),
            )
        ],
      ),
    );
  }

  buildContextText(SyncDialogController syncDialogController) {
    switch (syncDialogController.state.value) {
      case SyncState.NEW:
        return 'Yeni bir güncelleme bulundu.Lütfen güncelle butonuna basınız!';
      case SyncState.FAILED:
        return 'Güncellemeler yüklenirken bir hata oluştu.Lütfen tekrar deneyiniz!';
      case SyncState.LOADING:
        return 'Güncellemeler yükleniyor...';
      case SyncState.SUCCESS:
        return 'Güncellemeler başarıyla yüklendi.Lütfen programı tekrar başlatınız!';
      default:
        return 'Hata';
    }
  }

  Widget buildContentIcon(SyncDialogController syncDialogController) {
    switch (syncDialogController.state.value) {
      case SyncState.NEW:
        return const Icon(Icons.sync);
      case SyncState.FAILED:
        return const Icon(Icons.error_outline);
      case SyncState.LOADING:
        return const CircularProgressIndicator();
      case SyncState.SUCCESS:
        return const Icon(Icons.check);
      default:
        return Container();
    }
  }
}
