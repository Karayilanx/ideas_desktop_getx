// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:ideas_desktop/model/settings_model.dart';

import 'login/model/terminal_user.dart';

class AuthStore extends GetxService {
  Rx<TerminalUser?> _user = Rx<TerminalUser?>(null);
  Rx<SettingsModel?> _settings = Rx<SettingsModel?>(null);
  RxBool serverChecked = RxBool(false);
  RxBool autoLockTimerStarted = RxBool(false);

  void setUser(TerminalUser user) {
    _user(user);
  }

  void setServerChecked(bool b) {
    serverChecked(b);
  }

  void setAutoLockTimerStarted(bool b) {
    autoLockTimerStarted(b);
  }

  void setSettings(SettingsModel settings) {
    _settings(settings);
  }

  TerminalUser? get user => _user.value;
  SettingsModel? get settings => _settings.value;
}
