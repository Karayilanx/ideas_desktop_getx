import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/service/server/server_service.dart';

import 'sync_state_enum.dart';

class SyncDialogController extends BaseController {
  ServerService serverService = Get.find();
  Rx<SyncState> state = Rx<SyncState>(SyncState.NEW);

  Future syncChanges() async {
    changeState(SyncState.LOADING);
    var res = await serverService.syncChanges(authStore.user!.branchId!);
    if (res != null) {
      changeState(SyncState.SUCCESS);
    } else {
      changeState(SyncState.FAILED);
    }
  }

  changeState(SyncState s) {
    state(s);
  }
}
