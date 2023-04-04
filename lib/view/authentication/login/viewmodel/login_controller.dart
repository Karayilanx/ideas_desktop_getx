import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';
import 'package:ideas_desktop/service/branch/branch_service.dart';
import 'package:ideas_desktop/service/server/server_service.dart';
import 'package:ideas_desktop/signalr/signalr_manager.dart';

import '../../../../locale_keys_enum.dart';
import '../model/login_input.dart';
import '../model/terminal_user.dart';
import '../service/login_service.dart';

class LoginController extends BaseController {
  final TextEditingController pinFieldController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  LoginService loginService = Get.find();
  BranchService branchService = Get.find();
  ServerService serverService = Get.find();
  RxBool showEmail = RxBool(false);
  // Rx<Offset> offset = Rx<Offset>(Offset(20, 40));
  // OverlayEntry? entry;

  @override
  void onInit() {
    super.onInit();
    String email = localeManager.getStringValue(PreferencesKeys.BRANCH_EMAIL);
    if (email == '') showEmail(true);
    emailController.text = email;
    // loginTerminal();
  }

  loginTerminal() async {
    if (emailController.text.isNotEmpty) {
      LoginInput input = LoginInput(
          email: emailController.text, pass: pinFieldController.text);
      EasyLoading.show(
        status: 'Lütfen bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      TerminalUser? user = await loginService.loginTerminal(input);
      EasyLoading.dismiss();
      if (user != null) {
        localeManager.setStringValue(PreferencesKeys.BRANCH_EMAIL, user.email!);
        authStore.setUser(user);
        EasyLoading.show(
          status: 'Lütfen bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var settings = await branchService.getSettings(user.branchId!);
        EasyLoading.dismiss();
        authStore.setSettings(settings!);
        Get.offAllNamed('/home');
      } else {
        pinFieldController.text = "";
      }
    }
  }

  void openSettingsPage() async {
    String email = localeManager.getStringValue(PreferencesKeys.BRANCH_EMAIL);
    emailController.text = email;
    final SignalRManager? signalRManager = SignalRManager.instance;
    signalRManager!.hubConnection.start()!.timeout(const Duration(seconds: 5));
    signalRManager.serverHubConnection
        .start()!
        .timeout(const Duration(seconds: 5));
  }
}
