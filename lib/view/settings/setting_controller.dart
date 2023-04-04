// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/base_controller.dart';

import '../../locale_keys_enum.dart';
import '../../signalr/signalr_manager.dart';

enum SettingsPageTabEnum { Connection, Visual, Integration, Other }

class SettingsController extends BaseController {
  final TextEditingController ipCtrl = TextEditingController();
  final TextEditingController cashPrinterNameCtrl = TextEditingController();
  final TextEditingController serverIpCtrl = TextEditingController();
  final TextEditingController usernametrl = TextEditingController();
  final TextEditingController tableWidthCtrl = TextEditingController();
  final TextEditingController menuItemWidthCtrl = TextEditingController();

  Rx<SettingsPageTabEnum> pageTab =
      Rx<SettingsPageTabEnum>(SettingsPageTabEnum.Connection);
  RxBool showScreenKeyboard = RxBool(false);
  RxBool useYemeksepeti = RxBool(false);
  RxBool useGetir = RxBool(false);
  RxBool useFuudy = RxBool(false);
  RxBool autoSearch = RxBool(false);
  RxBool tableGroupDivider = RxBool(false);
  RxBool autoLock2 = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    ipCtrl.text = localeManager.getStringValue(PreferencesKeys.IP_ADDRESS);
    cashPrinterNameCtrl.text =
        localeManager.getStringValue(PreferencesKeys.CASH_PRINTER_NAME);
    serverIpCtrl.text =
        localeManager.getStringValue(PreferencesKeys.SERVER_IP_ADDRESS);
    usernametrl.text =
        localeManager.getStringValue(PreferencesKeys.BRANCH_EMAIL);
    tableWidthCtrl.text =
        localeManager.getStringValue(PreferencesKeys.TABLE_WIDTH);
    menuItemWidthCtrl.text =
        localeManager.getStringValue(PreferencesKeys.MENU_ITEM_WIDTH);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeshowScreenKeyboard(
          localeManager.getBoolValue(PreferencesKeys.SCREEN_KEYBOARD));
      changeYemeksepeti(
          localeManager.getBoolValue(PreferencesKeys.USE_YEMEKSEPETI));
      changeGetir(localeManager.getBoolValue(PreferencesKeys.USE_GETIR));
      changeFuudy(localeManager.getBoolValue(PreferencesKeys.USE_FUUDY));
      changeSearch(localeManager.getBoolValue(PreferencesKeys.AUTO_SEARCH));
      changeTableGroupDivider(
          localeManager.getBoolValue(PreferencesKeys.TABLE_GROUP_DIVIDER));
      changeAutoLock2(localeManager.getBoolValue(PreferencesKeys.AUTO_LOCK_2));
    });
  }

  changeTab(SettingsPageTabEnum tab) {
    pageTab(tab);
  }

  changeshowScreenKeyboard(bool val) {
    showScreenKeyboard(val);
  }

  changeYemeksepeti(bool val) {
    useYemeksepeti(val);
  }

  changeGetir(bool val) {
    useGetir(val);
  }

  changeFuudy(bool val) {
    useFuudy(val);
  }

  changeSearch(bool val) {
    autoSearch(val);
  }

  changeTableGroupDivider(bool val) {
    tableGroupDivider(val);
  }

  changeAutoLock2(bool val) {
    autoLock2(val);
  }

  void save() async {
    await localeManager.setStringValue(PreferencesKeys.IP_ADDRESS, ipCtrl.text);
    await localeManager.setStringValue(
        PreferencesKeys.SERVER_IP_ADDRESS, serverIpCtrl.text);
    await localeManager.setStringValue(
        PreferencesKeys.BRANCH_EMAIL, usernametrl.text);
    await localeManager.setBoolValue(
        PreferencesKeys.SCREEN_KEYBOARD, showScreenKeyboard.value);
    await localeManager.setBoolValue(
        PreferencesKeys.USE_YEMEKSEPETI, useYemeksepeti.value);
    await localeManager.setBoolValue(PreferencesKeys.USE_GETIR, useGetir.value);
    await localeManager.setBoolValue(PreferencesKeys.USE_FUUDY, useFuudy.value);
    await localeManager.setBoolValue(
        PreferencesKeys.AUTO_SEARCH, autoSearch.value);
    await localeManager.setBoolValue(
        PreferencesKeys.TABLE_GROUP_DIVIDER, tableGroupDivider.value);
    await localeManager.setBoolValue(
        PreferencesKeys.AUTO_LOCK_2, autoLock2.value);
    await localeManager.setStringValue(
        PreferencesKeys.TABLE_WIDTH, tableWidthCtrl.text);
    await localeManager.setStringValue(
        PreferencesKeys.MENU_ITEM_WIDTH, menuItemWidthCtrl.text);
    await localeManager.setStringValue(
        PreferencesKeys.CASH_PRINTER_NAME, cashPrinterNameCtrl.text);
    SignalRManager.reset();
    Get.deleteAll();
    Get.offAndToNamed('/');
  }
}
